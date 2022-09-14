final class FirebaseAppDummy: FirebaseConfigurable {

    class func configure() {}

}

final class LocalDataServiceUITestsStub: LocalDataService {
    
    func loadUserTickersId() -> [String] {
        ["btc-pln", "xxx-zzz"]
    }
    
    func loadTickers() -> [Ticker] {
        [.stub, .stub3]
    }
    
    func save(userTickersId: [String]) {}
    
    func save(tickers: [Ticker]) {}
    
}

final class TickerFetcherUITestsStub: TickerFetcher {
    
    enum CustomError: Error {
        case fetch
    }
    
    enum Variant {
        
        case standard
        case error
        
    }
    
    let variant: Variant
    
    init(variant: Variant = .standard) {
        self.variant = variant
    }
    
    func fetch() async throws -> [Ticker] {
        switch variant {
        case .standard:
            return [.stub, .stub2]
            
        case .error:
            throw CustomError.fetch
        }
    }
    
}

private extension Ticker {
    
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
    
}
