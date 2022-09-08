@testable import Zonda_Tickers

extension Ticker {
    
    static var stub: Self {
        .init(
            firstCurrency: .init(id: "btc", name: "Bitcoin", precision: 8),
            secondCurrency: .init(id: "pln", name: "Złoty", precision: 2),
            highestBid: 1,
            lowestAsk: 2,
            rate: 3,
            previousRate: 4,
            highestRate: 5,
            lowestRate: 6,
            volume: 7,
            average: 8
        )
    }
    
    static var stub2: Self {
        .init(
            firstCurrency: .init(id: "eth", name: "Ethereum", precision: 8),
            secondCurrency: .init(id: "usd", name: "Dollar", precision: 2),
            highestBid: 1,
            lowestAsk: 2,
            rate: 3,
            previousRate: 4,
            highestRate: 5,
            lowestRate: 6,
            volume: 7,
            average: 8
        )
    }
    
}
