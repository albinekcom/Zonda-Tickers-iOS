import Combine
import Foundation
import WidgetKit

final class ModelData: ObservableObject {
    
    enum State {
        
        case initializing
        case refreshing
        case refreshingSuccess
        case refreshingFailure(error: Error)
        
    }
    
    private let refreshingTickersIntervalInSeconds: TimeInterval = 15
    
    @Published private(set) var state: State = .initializing
    
    @Published private var userTickersId: [String]
    @Published private var tickers: [Ticker]
    
    private var timer: Timer?
    
    var analyticsService: AnalyticsService?
    
    var availableTickers: [Ticker] {
        tickers.filter { userTickersId.contains($0.id) == false }
    }
    
    var userTickers: [Ticker] {
        userTickersId.compactMap { userTickerId in tickers.first(where: { $0.id == userTickerId }) }
    }
    
    func ticker(for tickerId: String) -> Ticker? {
        tickers.first(where: { $0.id == tickerId })
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let localStore = LocalStore()
    private let tickerWebService = TickerWebService()
    
    init() {
        userTickersId = localStore.load(from: .userTickerIds) ?? []
        tickers = localStore.load(from: .tickers) ?? []
        
        $tickers.sink { newTickers in
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.localStore.save(newTickers, in: .tickers)
            }
            
            WidgetCenter.shared.reloadAllTimelines()
        }.store(in: &cancellables)
        
        $userTickersId.sink { newUserTickersId in
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.localStore.save(newUserTickersId, in: .userTickerIds)
            }
            
            WidgetCenter.shared.reloadAllTimelines()
        }.store(in: &cancellables)
        
        startAutomaticRefreshing()
    }
    
    func reloadLocalTickers() {
        tickers = localStore.load(from: .tickers) ?? []
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
    
    private func removeUnsupportedUserTickersId() {
        let supportedTickersIdSet = Set(tickers.map(\.id))
        let userTickerIdsSet = Set(userTickersId)
        
        let tickersIdToRemove = Array(userTickerIdsSet.subtracting(supportedTickersIdSet))
        
        tickersIdToRemove.forEach {
            if let index = userTickersId.firstIndex(of: $0) {
                userTickersId.remove(at: index)
            }
        }
    }
    
    @MainActor
    private func refreshTickers() async {
        state = .refreshing
        
        do {
            tickers = try await tickerWebService.fetch()
            
            removeUnsupportedUserTickersId()
            
            state = .refreshingSuccess
            
            analyticsService?.trackUserTickersRefreshed(tickerIds: userTickersId)
        } catch {
            state = .refreshingFailure(error: error)
            
            analyticsService?.trackUserTickersRefreshingFailed(tickerIds: userTickersId)
        }
    }
    
    @objc private func startAutomaticRefreshing() {
        Task {
            await refreshTickers()
            
            timer = Timer.scheduledTimer(
                withTimeInterval: refreshingTickersIntervalInSeconds,
                repeats: false,
                block: { [weak self] _ in self?.startAutomaticRefreshing() }
            )
        }
    }
    
}
