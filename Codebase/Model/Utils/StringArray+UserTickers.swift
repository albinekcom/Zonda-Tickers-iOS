extension Array where Element == String {
    
    func userTickers(from tickers: [Ticker]) -> [Ticker] {
        compactMap { tickers.ticker(id: $0) ?? .init(id: $0) }
    }
    
}
