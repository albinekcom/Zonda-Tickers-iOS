import Foundation

final class UserData: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    @Published var tickersIdentifiersAvailableToAdd: [TickerIdentifier] = []
    @Published var fetchingError: Error? = nil
    
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
    
//    static let sharedDefaultsIdentifier = "group.com.albinek.ios.BitBay-Ticker.shared.defaults" // TODO: Key in old version, use it for migrator
    static private let userDataTickersFileName: String = "user_data_tickers_v1.json"
    private let timeBetweenRefreshesInSeconds: TimeInterval = 5
    private let minimumTimeBetweenNextPossibleTickerIndentifiersRefresh: TimeInterval = .oneHour
    
    private var refreshingTimer: Timer?
    
    private var lastSuccesfullyTickersIdentifiersFetchedDate: Date?
    
    private let tickerIdentifiersFetcher: TickerIdentifiersFetcher = TickerIdentifiersFetcher()
    private let tickerValuesFetcher: TickerValuesFetcher = TickerValuesFetcher()
    private let tickerStatisticsFetcher: TickerStatisticsFetcher = TickerStatisticsFetcher()
    
    func setupRefreshingTimer() {
        guard isEditing == false else { return }
        guard refreshingTimer == nil else { return }
        
        refreshingTimer = Timer.scheduledTimer(timeInterval: timeBetweenRefreshesInSeconds, target: self, selector: #selector(refreshAllTickers), userInfo: nil, repeats: true)
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
        if let lastSuccesfullyTickersIdentifiersFetchedDate = lastSuccesfullyTickersIdentifiersFetchedDate, Date().timeIntervalSince(lastSuccesfullyTickersIdentifiersFetchedDate) < minimumTimeBetweenNextPossibleTickerIndentifiersRefresh {
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
    
    // MARK: - Storing
    
    func loadUserData(completion: (() -> (Void))? = nil) {
        defer {
            completion?()
        }
        
        DispatchQueue.global(qos: .background).async {
            if Storage.fileExists(UserData.userDataTickersFileName, in: .documents) {
                let tickersFromFile = Storage.retrieve(UserData.userDataTickersFileName, from: .documents, as: [Ticker].self)
                
                DispatchQueue.main.async { [weak self] in
                    self?.tickers = tickersFromFile
                }
            }
        }
    }
    
    func saveUserData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            Storage.store(self?.tickers, to: .documents, as: UserData.userDataTickersFileName)
        }
    }
    
}
