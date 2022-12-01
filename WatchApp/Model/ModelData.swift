import Combine

final class ModelData: ObservableObject {
    
    var userTickers: [Ticker] {
        userTickerIds.userTickers(from: tickers)
    }
    
    @Published private var tickers: [Ticker] = []
    @Published private var userTickerIds: [String] = []
    
    private let userTickersIdService = UserTickersIdService()
    private let tickerService = TickerService()
    
    private let connectivityReceiver = iOSConnectivityReceiver()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        connectivityReceiver
            .$tickers
            .weakAssign(to: \.tickers, on: self)
            .store(in: &cancellables)
        
        connectivityReceiver
            .$userTickersIds
            .weakAssign(to: \.userTickerIds, on: self)
            .store(in: &cancellables)
    }
    
    @MainActor
    func refresh() async {
        tickers = (try? await tickerService.fetched) ?? tickerService.loaded
    }
    
}

private extension Publisher where Failure == Never {
    
    func weakAssign<T: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<T, Output>,
        on object: T
    ) -> AnyCancellable {
        sink { [weak object] in
            object?[keyPath: keyPath] = $0
        }
    }
    
}
