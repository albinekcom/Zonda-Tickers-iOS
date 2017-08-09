import Foundation

struct AnalyticsParametersFactory {
    
    static func makeParameters(from ticker: Ticker) -> [String: String] {
        return ["Ticker": ticker.prettyName]
    }
    
    static func makeParameters(from tickers: [Ticker]) -> [String: String] {
        let tickersPrettyNames = tickers.map { $0.prettyName }
            
        let compoundedTickersPrettyNames = tickersPrettyNames.joined(separator: "|")
    
        return ["Tickers": compoundedTickersPrettyNames]
    }
    
}
