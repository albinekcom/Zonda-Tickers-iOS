import Combine
import WidgetKit

final class ModelData: ObservableObject {
    
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
    
    @Published private var userTickerIds: [String]
    @Published private var tickers: [Ticker]
    
    private let widgetReloadable: WidgetReloadable
    
    private let connectivityProvider: ConnectivityProvider
    
    private var cancellables = Set<AnyCancellable>()
    
    private let userTickersIdService: UserTickersIdService
    private let tickerService: TickerService
    
    init(
        userTickersIdService: UserTickersIdService,
        tickerService: TickerService,
        widgetReloadable: WidgetReloadable = WidgetCenter.shared,
        connectivityProvider: ConnectivityProvider = WatchOSConnectivityProvider()
    ) {
        self.userTickersIdService = userTickersIdService
        self.tickerService = tickerService
        self.widgetReloadable = widgetReloadable
        self.connectivityProvider = connectivityProvider
        
        userTickerIds = userTickersIdService.loaded
        tickers = tickerService.loaded
        
        $tickers.sink { [weak self] in
            self?.widgetReloadable.reloadAllTimelines()
            self?.connectivityProvider.send(tickers: $0)
        }.store(in: &cancellables)
        
        $userTickerIds.sink { [weak self] in
            self?.userTickersIdService.save(userTickersId: $0)
            
            self?.widgetReloadable.reloadAllTimelines()
            self?.connectivityProvider.send(userTickerIds: $0)
        }.store(in: &cancellables)
    }
    
    convenience init(
        serviceFactory: ServiceFactory = .init()
    ) {
        let localDataService = serviceFactory.makeLocalDataService()
        
        self.init(
            userTickersIdService: .init(localDataService: localDataService),
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
    
}
