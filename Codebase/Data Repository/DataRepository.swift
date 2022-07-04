import Combine

final class DataRepository {
    
    enum State {
        
        case initializing
        case fetching
        case fetchedSuccessfully
        case fetchingFailed(error: Error)
        
    }
    
    private static let remoteDataFetchingIntervalInSeconds: Double = 10
    
    @Published private(set) var tickers: [Ticker]
    @Published var userTickerIds: [String]
    
    @Published private(set) var state: State = .initializing
    
    private let localDataRepository = LocalDataRepository()
    private let remoteDataRepository = RemoteDataRepository()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        tickers = localDataRepository.loadTickers() ?? []
        userTickerIds = localDataRepository.loadUserTickerIds() ?? []
        
        $tickers
            .sink { [weak self] in self?.localDataRepository.saveTickers($0) }
            .store(in: &cancellables)
        
        $userTickerIds
            .sink { [weak self] in self?.localDataRepository.saveUserTickerIds($0) }
            .store(in: &cancellables)
        
        Task {
            await startAutomaticFetchingRemoteData()
        }
    }
    
    @MainActor
    private func startAutomaticFetchingRemoteData() async {
        state = .fetching
        
        do {
            tickers = try await remoteDataRepository.fetch()
            
            state = .fetchedSuccessfully
            
            AnalyticsService.shared.trackUserTickersRefreshed(tickerIds: userTickerIds)
        } catch {
            state = .fetchingFailed(error: error)
            
            AnalyticsService.shared.trackUserTickersRefreshingFailed(tickerIds: userTickerIds)
        }
        
        try? await Task.sleep(seconds: Self.remoteDataFetchingIntervalInSeconds)
        
        await startAutomaticFetchingRemoteData()
    }
    
}

private extension Task where Success == Never, Failure == Never {
    
    static func sleep(seconds: Double) async throws {
        try await Task.sleep(nanoseconds: UInt64(seconds) * 1_000_000_000)
    }
    
}
