struct AnalyticsParametersFactory {
    
    static func makeParameters(from ticker: Ticker) -> [String: String] {
        return ["Ticker": ticker.id]
    }
    
    static func makeParameters(from tickerIdentifier: TickerIdentifier) -> [String: String] {
        return ["Ticker": tickerIdentifier.id]
    }
    
}
