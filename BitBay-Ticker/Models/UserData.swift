import Foundation

final class UserData: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    @Published var availableTickersIdentifiersToAdd: [TickerIdentifier] = []
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
    
    static private let userDataTickersFileName: String = "user_data_tickers.json"
    
    private let timeBetweenRefreshesInSeconds: TimeInterval = 5
    
    private var refreshingTimer: Timer?
    
    private let allAvailableTickerIdentifiersFetcher: AllAvailableTickerIdentifiersFetcher = AllAvailableTickerIdentifiersFetcher()
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
        availableTickersIdentifiersToAdd.removeAll { $0 == tickerIdentifier }
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
                    var refreshedTicker = ticker
                    
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
                    
                    if let index = self?.tickers.firstIndex(of: ticker) {
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
            var refreshedTicker = ticker
            
            switch result {
                case .success(let response):
                    refreshedTicker.highestRate = response?.h.doubleValue
                    refreshedTicker.lowestRate = response?.l.doubleValue
                    refreshedTicker.volume = response?.v.doubleValue
                    refreshedTicker.average = response?.r24h.doubleValue
                    
                    if let index = self?.tickers.firstIndex(of: ticker) {
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
    
    func refreshAllAvailableTickersIdentifiersToAdd() {
        allAvailableTickerIdentifiersFetcher.fetch { [weak self] result in
            switch result {
                case .success(let allAvailableTickersIdentifiers):
                    let userTickerIdentifiers = self?.tickers.map { TickerIdentifier(id: $0.id) } ?? []
                    
                    self?.availableTickersIdentifiersToAdd = allAvailableTickersIdentifiers.filter { userTickerIdentifiers.contains($0) == false }
                case .failure(let error):
                    self?.availableTickersIdentifiersToAdd = []
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
