import Foundation

final class UserTickerStore: ObservableObject {
    
    @Published private(set) var tickers: [Ticker] = []
    
    private let userTickersIdService = UserTickersIdService()
    private let tickerService = TickerService()
    
    private var userTickersIds: [String] {
        userTickersIdService.loaded
    }
    
    init() {
//        tickers = userTickersIds.userTickers(from: tickerService.loaded) // TODO: Change it later
        tickers = [
            .init(
                firstCurrency: .init(id: "btc"),
                secondCurrency: .init(id: "pln"),
                rate: 123.45,
                previousRate: 12344,
                average: 100
            ),
            .init(
                firstCurrency: .init(id: "eth"),
                secondCurrency: .init(id: "usd"),
                rate: 22.33,
                average: 30
            )
        ]
    }
    
    @MainActor
    func refresh() async {
//        tickers = userTickersIds.userTickers(from: (try? await tickerService.fetched) ?? tickerService.loaded) // TODO: Change it later
    }
    
}
