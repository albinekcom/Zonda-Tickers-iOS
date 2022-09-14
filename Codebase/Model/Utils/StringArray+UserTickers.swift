extension Array where Element == String {
    
    func userTickers(from tickers: [Ticker]) -> [Ticker] {
        compactMap { tickerId in tickers.first(where: { $0.id == tickerId }) ?? .init(id: tickerId) }
    }
    
}
