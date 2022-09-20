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
    
    @Published private var userTickersId: [String]
    @Published private var tickers: [Ticker]
    
    private let widgetReloadable: WidgetReloadable
    
    private var cancellables = Set<AnyCancellable>()
    
    private let userTickersIdService: UserTickersIdService
    private let tickerService: TickerService
    
    init(
        userTickersIdService: UserTickersIdService,
        tickerService: TickerService,
        widgetReloadable: WidgetReloadable = WidgetCenter.shared
    ) {
        self.userTickersIdService = userTickersIdService
        self.tickerService = tickerService
        self.widgetReloadable = widgetReloadable
        
        userTickersId = userTickersIdService.loaded
        tickers = tickerService.loaded
        
        $tickers.sink { [weak self] _ in
            self?.widgetReloadable.reloadAllTimelines()
        }.store(in: &cancellables)
        
        $userTickersId.sink { [weak self] in
            self?.userTickersIdService.save(userTickersId: $0)
            
            self?.widgetReloadable.reloadAllTimelines()
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
            .filter { userTickersId.contains($0.id) == false }
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
        userTickersId.userTickers(from: tickers)
    }
    
    func ticker(for tickerId: String) -> Ticker? {
        tickers.first(where: { $0.id == tickerId })
    }
    
    func appendUserTickerId(_ tickerId: String) {
        userTickersId.append(tickerId)
        
        analyticsService?.trackUserTickerAppended(tickerId: tickerId)
    }
    
    func removeUserTicker(at offsets: IndexSet) {
        let removedTickerId = userTickersId[offsets.map { $0 }[0]]
        
        userTickersId.remove(atOffsets: offsets)
        
        analyticsService?.trackUserTickerDeleted(tickerId: removedTickerId)
    }
    
    func moveUserTicker(from source: IndexSet, to destination: Int) {
        userTickersId.move(fromOffsets: source, toOffset: destination)
    }
    
    @MainActor
    func refreshTickers() async {
        state = .refreshing
        
        do {
            tickers = try await tickerService.fetched
            
            state = .refreshingSuccess
            
            analyticsService?.trackUserTickersRefreshed(tickerIds: userTickersId)
        } catch {
            state = .refreshingFailure(error: error)
            
            analyticsService?.trackUserTickersRefreshingFailed(tickerIds: userTickersId)
        }
    }
    
}
