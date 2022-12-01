import Combine
import WidgetKit

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
        userTickerIds = userTickersIdService.loaded
        tickers = tickerService.loaded
        
        connectivityReceiver
            .$tickers
            .weakAssign(to: \.tickers, on: self)
            .store(in: &cancellables)
        
        connectivityReceiver
            .$userTickersIds
            .weakAssign(to: \.userTickerIds, on: self)
            .store(in: &cancellables)
        
        $tickers.sink { [weak self] _ in
            self?.refreshWidgets()
        }.store(in: &cancellables)
        
        $userTickerIds.sink { [weak self] in
            self?.userTickersIdService.save(userTickersId: $0)
            
            self?.refreshWidgets()
        }.store(in: &cancellables)
    }
    
    @MainActor
    func refresh() async {
        guard let fetchedTickers = try? await tickerService.fetched else { return }
        
        tickers = fetchedTickers
        
        print("Fetched")
    }
    
    private func refreshWidgets() {
        if #available(watchOS 9.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
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
