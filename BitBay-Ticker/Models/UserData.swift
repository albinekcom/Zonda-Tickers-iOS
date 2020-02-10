import Foundation

final class UserData: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    @Published var areTickersLoaded: Bool = false
    
    @Published private(set) var tickersIdentifiersAvailableToAdd: [TickerIdentifier] = []
    
    @Published private(set) var fetchingTickerPropertiesError: Error?
    @Published private(set) var fetchingTickerIdentifiersError: Error?
    
    var isEditing: Bool = false { // HACK
        willSet {
            if isEditing == false && newValue {
                invalidRefreshingTimer()
                
                AnalyticsService.shared.trackEditTickersView()
            } else if isEditing && newValue == false {
                setupRefreshingTimer()
            }
        }
    }
    
    var isAdding: Bool = false {
        didSet {
            if isAdding {
                invalidRefreshingTimer()
            } else if isEditing == false {
                setupRefreshingTimer()
            }
        }
    }
    
    private var refreshingTimer: Timer?
    private var lastSuccesfullyTickersIdentifiersFetchedDate: Date?
    
    private let supportedTickersFetcher: SupportedTickersFetcher = SupportedTickersFetcher()
    private let tickerPropertiesFetcher: TickerPropertiesFetcher = TickerPropertiesFetcher()
    
    func setupRefreshingTimer() {
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
        guard tickers.contains(where: {$0.id == tickerIdentifier.id}) == false else { return }
        
        let ticker = Ticker(id: tickerIdentifier.id)
        
        tickers.append(ticker)
        
        refresh(tickers: [ticker], source: .automaticAfterAddingTicker)
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
        refresh(tickers: tickers, source: .automatic)
    }
    
    func refresh(tickers: [Ticker], source: AnalyticsService.Source) {
        guard tickers.isEmpty == false else { return }
        
        tickerPropertiesFetcher.fetch(for: tickers) { [weak self] result in
            switch result {
                case .success(let refreshedTickers):
                    for refreshedTicker in refreshedTickers {
                        if let tickerIndex = self?.tickers.firstIndex(where: { $0.id == refreshedTicker.id }) {
                            self?.tickers[tickerIndex] = refreshedTicker
                        }
                    }
                    
                    let analyticsParameters = AnalyticsParametersFactory.makeParameters(from: refreshedTickers)
                    AnalyticsService.shared.trackRefreshedTickers(parameters: analyticsParameters, source: source)
                
                    self?.fetchingTickerPropertiesError = nil
                
                case .failure(let error):
                    AnalyticsService.shared.trackRefreshingTickersFailed(source: source)
                    
                    self?.fetchingTickerPropertiesError = error
            }
        }
        
    }
    
    func refreshTickersIdentifiers() {
        if let lastSuccesfullyTickersIdentifiersFetchedDate = lastSuccesfullyTickersIdentifiersFetchedDate, Date().timeIntervalSince(lastSuccesfullyTickersIdentifiersFetchedDate) < AppConfiguration.UserData.minimumTimeSpanBetweenTickerIndentifiersRefreshes {
            return
        }
        
        supportedTickersFetcher.fetch { [weak self] result in
            switch result {
                case .success(let tickersIdentifiers):
                    self?.removeUnsupportedTickers(fetchedTickersIdentifiers: tickersIdentifiers)
                    self?.updateTickersIdentifiersAvailableToAdd(fetchedTickersIdentifiers: tickersIdentifiers)
                    
                    self?.lastSuccesfullyTickersIdentifiersFetchedDate = Date()
                    
                    self?.fetchingTickerIdentifiersError = nil
                case .failure(let error):
                    self?.fetchingTickerIdentifiersError = error
            }
        }
    }
    
    private func removeUnsupportedTickers(fetchedTickersIdentifiers: [TickerIdentifier]) {
        let tickersToRemoveFromUserTickers = tickers.filter { fetchedTickersIdentifiers.contains(TickerIdentifier(id: $0.id)) == false }
        
        for tickerToRemove in tickersToRemoveFromUserTickers {
            if let index = tickers.firstIndex(of: tickerToRemove) {
                tickers.remove(at: index)
            }
        }
    }
    
    private func updateTickersIdentifiersAvailableToAdd(fetchedTickersIdentifiers: [TickerIdentifier]) {
        TickerIdentifiersStore.shared.tickerIdentifiers = fetchedTickersIdentifiers
        
        let tickerIdentifiersOfUserTickers = tickers.map { TickerIdentifier(id: $0.id) }
        tickersIdentifiersAvailableToAdd = fetchedTickersIdentifiers.filter { tickerIdentifiersOfUserTickers.contains($0) == false }
    }
    
}
