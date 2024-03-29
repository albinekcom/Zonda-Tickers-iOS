import Combine
import WidgetKit

final class ModelData: ObservableObject, ConnectivityProviderDelegate {
    
    enum State: Equatable {
        
        case initializing
        case refreshing
        case refreshingSuccess
        case refreshingFailure(error: Error)
        
        static func == (lhs: ModelData.State, rhs: ModelData.State) -> Bool {
            switch (lhs, rhs) {
            case (.initializing, .initializing),
                (.refreshing, .refreshing),
                (.refreshingSuccess, .refreshingSuccess),
                (.refreshingFailure, .refreshingFailure):
                return true
                
            default:
                return false
            }
        }
        
    }
    
    @Published private(set) var state: State = .initializing
    
    var analyticsService: AnalyticsService?
    
    @Published private(set) var userTickerIds: [String]
    @Published private var tickers: [Ticker]
    
    private let widgetReloadable: WidgetReloadable
    
    private let connectivityProvider: ConnectivityProvider
    
    private var cancellables = Set<AnyCancellable>()
    
    private let userTickerIdService: UserTickerIdService
    private let tickerService: TickerService
    
    init(
        userTickerIdService: UserTickerIdService,
        tickerService: TickerService,
        widgetReloadable: WidgetReloadable = WidgetCenter.shared,
        connectivityProvider: ConnectivityProvider = WatchConnectivityProvider()
    ) {
        self.userTickerIdService = userTickerIdService
        self.tickerService = tickerService
        self.widgetReloadable = widgetReloadable
        self.connectivityProvider = connectivityProvider
        
        userTickerIds = userTickerIdService.loaded
        tickers = tickerService.loaded
        
        connectivityProvider.delegate = self
        
        $tickers.sink { [weak self] _ in
            self?.widgetReloadable.reloadAllTimelines()
        }.store(in: &cancellables)
        
        $userTickerIds.sink { [weak self] in
            guard let self = self else { return }
            
            self.userTickerIdService.save(userTickerIds: $0)
            
            self.connectivityProvider.update(
                tickers: self.tickers,
                userTickerIds: $0
            )
            
            self.widgetReloadable.reloadAllTimelines()
        }.store(in: &cancellables)
    }
    
    convenience init(serviceFactory: ServiceFactory = .init()) {
        let localDataService = serviceFactory.makeLocalDataService()
        
        self.init(
            userTickerIdService: .init(localDataService: localDataService),
            tickerService: .init(
                localDataService: localDataService,
                tickerFetcher: serviceFactory.makeTickerFetcher()
            )
        )
    }
    
    func availableTickers(searchText: String = "") -> [Ticker] {
        tickers
            .filter { userTickerIds.contains($0.id) == false }
            .filter {
                if searchText.isEmpty { return true }
                
                for searchTag in searchText.components(separatedBy: " ") {
                    if $0.tags.joined(separator: " ").contains(searchTag.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()) {
                        return true
                    }
                }
                
                return false
            }
    }
    
    var userTickers: [Ticker] {
        userTickerIds.userTickers(from: tickers)
    }
    
    func ticker(id: String) -> Ticker? {
        tickers.ticker(id: id)
    }
    
    func appendUserTickerId(_ tickerId: String) {
        userTickerIds.append(tickerId)
        
        analyticsService?.trackUserTickerAppended(tickerId: tickerId)
    }
    
    func removeUserTicker(at offsets: IndexSet) {
        let removedTickerId = userTickerIds[offsets.map { $0 }[0]]
        
        userTickerIds.remove(atOffsets: offsets)
        
        analyticsService?.trackUserTickerDeleted(tickerId: removedTickerId)
    }
    
    func moveUserTicker(from source: IndexSet, to destination: Int) {
        userTickerIds.move(fromOffsets: source, toOffset: destination)
    }
    
    @MainActor
    func refreshTickers() async {
        state = .refreshing
        
        do {
            tickers = try await tickerService.fetched
            
            state = .refreshingSuccess
            
            analyticsService?.trackUserTickersRefreshed(tickerIds: userTickerIds)
        } catch {
            state = .refreshingFailure(error: error)
            
            analyticsService?.trackUserTickersRefreshingFailed(tickerIds: userTickerIds)
        }
    }
    
    func reloadTickers() {
        tickers = tickerService.loaded
    }
    
}
