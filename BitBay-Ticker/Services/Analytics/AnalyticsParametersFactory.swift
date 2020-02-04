struct AnalyticsParametersFactory {
    
    static func makeParameters(from ticker: Ticker) -> [String: String] {
        return ["Ticker": ticker.id]
    }
    
    static func makeParameters(from tickers: [Ticker]) -> [String: String] {
        return ["Tickers": tickers.map { $0.id }.joined(separator: ",")]
    }
    
    static func makeParameters(from tickerIdentifier: TickerIdentifier) -> [String: String] {
        return ["Ticker": tickerIdentifier.id]
    }
    
}
