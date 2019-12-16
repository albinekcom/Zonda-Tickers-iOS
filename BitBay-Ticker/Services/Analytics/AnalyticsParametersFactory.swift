struct AnalyticsParametersFactory {
    
    static func makeParameters(from ticker: Ticker) -> [String: String] {
        return ["Ticker": ticker.id]
    }
    
}
