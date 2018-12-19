import Foundation

struct AnalyticsParametersFactory {
    
    static func makeParameters(from ticker: Ticker) -> [String: String] {
        return ["Ticker": ticker.prettyName]
    }
    
    static func makeParameters(from refreshingType: TickerStore.RefreshingType) -> [String: String] {
        return ["Refreshing_Type": refreshingType.rawValue]
    }
    
}
