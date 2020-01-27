import Foundation

final class UserData: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    @Published var tickersIdentifiersAvailableToAdd: [TickerIdentifier] = []
    @Published var fetchingError: Error?
    
    var isEditing: Bool = false { // HACK
        didSet {
            if isEditing {
                invalidRefreshingTimer()
            } else if isAdding == false {
                setupRefreshingTimer()
            }
        }
    }
    
    var isAdding: Bool = false {
        didSet {
            if isAdding {
                invalidRefreshingTimer()
            } else {
                setupRefreshingTimer()
            }
        }
    }
    
    private var refreshingTimer: Timer?
    private var lastSuccesfullyTickersIdentifiersFetchedDate: Date?
    
    private let tickerIdentifiersFetcher: TickerIdentifiersFetcher = TickerIdentifiersFetcher()
    private let tickerValuesFetcher: TickerValuesFetcher = TickerValuesFetcher()
    private let tickerStatisticsFetcher: TickerStatisticsFetcher = TickerStatisticsFetcher()
    
    func setupRefreshingTimer() {
        guard isEditing == false else { return }
        guard refreshingTimer == nil else { return }
        
        refreshingTimer = Timer.scheduledTimer(timeInterval: AppConfiguration.UserData.timeSpanBetweenTickerRefreshes, target: self, selector: #selector(refreshAllTickers), userInfo: nil, repeats: true)
    }
    
    func invalidRefreshingTimer() {
        refreshingTimer?.invalidate()
        refreshingTimer = nil
    }
    
    // MARK: - Managing
    
    func removeAvailableToAddTickerIdentifier(tickerIdentifier: TickerIdentifier) {
        tickersIdentifiersAvailableToAdd.removeAll { $0 == tickerIdentifier }
    }
    
    func appendAndRefreshTicker(from tickerIdentifier: TickerIdentifier) {
        let ticker = Ticker(id: tickerIdentifier.id)
        
        tickers.append(ticker)
        
        refresh(ticker: ticker)
    }
    
    func removeTicker(at index: Int) {
        let tickerToDelete = tickers.remove(at: index)
        
        let tickerIdentifiersOfUserTickers = tickers.map { TickerIdentifier(id: $0.id) }
        tickersIdentifiersAvailableToAdd = TickerIdentifiersStore.shared.tickerIdentifiers.filter { tickerIdentifiersOfUserTickers.contains($0) == false }
        
        let analyticsParamaters = AnalyticsParametersFactory.makeParameters(from: tickerToDelete)
        AnalyticsService.shared.trackRemovedTicker(parameters: analyticsParamaters)
    }
    
    // MARK: - Refreshing
    
    @objc func refreshAllTickers() {
        tickers.forEach { refresh(ticker: $0) }
    }
    
    func refresh(ticker: Ticker) {
        refreshValues(for: ticker)
    }
    
    private func refreshValues(for ticker: Ticker) {
        tickerValuesFetcher.fetch(for: ticker.id) { [weak self] result in
            switch result {
                case .success(let response):
                    var refreshedTicker: Ticker
                    
                    if let tickers = self?.tickers, let index = tickers.firstIndex(where: { $0.id == ticker.id }) {
                        refreshedTicker = tickers[index]
                    } else {
                        refreshedTicker = Ticker(id: ticker.id)
                    }
                    
                    refreshedTicker.highestBid = response?.highestBid.doubleValue
                    refreshedTicker.lowestAsk = response?.lowestAsk.doubleValue
                    refreshedTicker.rate = response?.rate.doubleValue
                    refreshedTicker.previousRate = response?.previousRate.doubleValue
                    
                    let firstCurrencyResponseFromAPI = response?.market?.first
                    let firstCurrency = Ticker.Currency(currency: firstCurrencyResponseFromAPI?.currency, minimumOffer: firstCurrencyResponseFromAPI?.minOffer.doubleValue, scale: firstCurrencyResponseFromAPI?.scale)
                    refreshedTicker.firstCurrency = firstCurrency
                    
                    let secondCurrencyResponseFromAPI = response?.market?.second
                    let secondCurrency = Ticker.Currency(currency: secondCurrencyResponseFromAPI?.currency, minimumOffer: secondCurrencyResponseFromAPI?.minOffer.doubleValue, scale: secondCurrencyResponseFromAPI?.scale)
                    refreshedTicker.secondCurrency = secondCurrency
                    
                    if let index = self?.tickers.firstIndex(where: { $0.id == ticker.id }) {
                        self?.tickers[index] = refreshedTicker
                    }
                    
                    let analyticsParameters = AnalyticsParametersFactory.makeParameters(from: ticker)
                    AnalyticsService.shared.trackRefreshedTickerValues(parameters: analyticsParameters)
                
                    self?.refreshStatistics(for: refreshedTicker)
                
                    self?.fetchingError = nil
                
                case .failure(let error):
                    self?.fetchingError = error
            }
        }
    }
    
    private func refreshStatistics(for ticker: Ticker) {
        tickerStatisticsFetcher.fetch(for: ticker.id) { [weak self] result in
            switch result {
                case .success(let response):
                    var refreshedTicker: Ticker
                    
                    if let tickers = self?.tickers, let index = tickers.firstIndex(where: { $0.id == ticker.id }) {
                        refreshedTicker = tickers[index]
                    } else {
                        refreshedTicker = Ticker(id: ticker.id)
                    }
                    
                    refreshedTicker.highestRate = response?.h.doubleValue
                    refreshedTicker.lowestRate = response?.l.doubleValue
                    refreshedTicker.volume = response?.v.doubleValue
                    refreshedTicker.average = response?.r24h.doubleValue
                    
                    if let index = self?.tickers.firstIndex(where: { $0.id == ticker.id }) {
                        self?.tickers[index] = refreshedTicker
                    }
                
                    let analyticsParameters = AnalyticsParametersFactory.makeParameters(from: ticker)
                    AnalyticsService.shared.trackRefreshedTickerStatistics(parameters: analyticsParameters)
                    
                    self?.fetchingError = nil
                case .failure(let error):
                    self?.fetchingError = error
            }
        }
    }
    
    func refreshTickersIdentifiers() {
        if let lastSuccesfullyTickersIdentifiersFetchedDate = lastSuccesfullyTickersIdentifiersFetchedDate, Date().timeIntervalSince(lastSuccesfullyTickersIdentifiersFetchedDate) < AppConfiguration.UserData.minimumTimeSpanBetweenTickerIndentifiersRefreshes {
            return
        }
        
        tickerIdentifiersFetcher.fetch { [weak self] result in
            switch result {
                case .success(let tickersIdentifiers):
                    TickerIdentifiersStore.shared.tickerIdentifiers = tickersIdentifiers
                
                    let tickerIdentifiersOfUserTickers = self?.tickers.map { TickerIdentifier(id: $0.id) } ?? []
                    
                    self?.tickersIdentifiersAvailableToAdd = tickersIdentifiers.filter { tickerIdentifiersOfUserTickers.contains($0) == false }
                
                    self?.lastSuccesfullyTickersIdentifiersFetchedDate = Date()
                case .failure(let error):
                    self?.fetchingError = error
            }
        }
    }
    
}
