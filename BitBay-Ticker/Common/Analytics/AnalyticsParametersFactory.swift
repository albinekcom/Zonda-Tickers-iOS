import Foundation

struct AnalyticsParametersFactory {
    
    static func makeParameters(from ticker: Ticker) -> [String: String] {
        return ["Ticker": ticker.prettyName]
    }
    
    static func makeParameters(from tickers: [Ticker]) -> [String: [String]] {
        let tickersPrettyNames = tickers.map { $0.prettyName }
        
        return ["Tickers": tickersPrettyNames]
    }

}
