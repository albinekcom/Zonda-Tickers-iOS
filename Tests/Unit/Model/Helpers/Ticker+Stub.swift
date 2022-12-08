@testable import Zonda_Tickers

extension Ticker {
    
    static var stub1: Self {
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
    
    static var stub3: Self {
        .init(
            firstCurrency: .init(id: "lsk", name: "Lisk", precision: 8),
            secondCurrency: .init(id: "eur", name: "Euro", precision: 2),
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
    
    static func stub(
        firstCurrency: Currency = .init(id: "btc"),
        secondCurrency: Currency = .init(id: "pln"),
        highestBid: Double? = nil,
        lowestAsk: Double? = nil,
        rate: Double? = nil,
        previousRate: Double? = nil,
        highestRate: Double? = nil,
        lowestRate: Double? = nil,
        volume: Double? = nil,
        average: Double? = nil
    ) -> Ticker {
        .init(
            firstCurrency: firstCurrency,
            secondCurrency: secondCurrency,
            highestBid: highestBid,
            lowestAsk: lowestAsk,
            rate: rate,
            previousRate: previousRate,
            highestRate: highestRate,
            lowestRate: lowestRate,
            volume: volume,
            average: average
        )
    }
    
}
