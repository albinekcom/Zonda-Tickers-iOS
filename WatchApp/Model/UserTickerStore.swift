import Foundation

final class UserTickerStore: ObservableObject {
    
    @Published private(set) var tickers: [Ticker] = []
    
    private let userTickersIdService = UserTickersIdService()
    private let tickerService = TickerService()
    
    private var userTickersIds: [String] {
        userTickersIdService.loaded
    }
    
    init() {
        tickers = userTickersIds.userTickers(from: tickerService.loaded)
    }
    
    @MainActor
    func refresh() async {
        tickers = userTickersIds.userTickers(from: (try? await tickerService.fetched) ?? tickerService.loaded)
    }
    
}
