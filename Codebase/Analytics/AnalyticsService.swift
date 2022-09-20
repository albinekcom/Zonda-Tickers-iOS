final class AnalyticsService {
    
    struct Track {
        
        enum Name: String {
            case userTickerAppended = "User_Ticker_Appended"
            case userTickerDeleted = "User_Ticker_Deleted"
            
            case userTickersRefreshed = "User_Tickers_Refreshed"
            case userTickersRefreshingFailed = "User_Tickers_Refreshing_Failed"
            
            case reviewRequested = "Requested_Review"
        }
        
        enum ParameterKey: String {
            
            case ticker = "Ticker"
            case tickers = "Tickers"
        }
        
    }
    
    private let logger: AnalyticsServiceLogger
    
    init(logger: AnalyticsServiceLogger = AnalyticsServiceFirebaseLogger()) {
        self.logger = logger
    }
    
    // MARK: - Tracks
    
    func trackView(tickerId: String? = nil) {
        let parameters: [Track.ParameterKey: String]?
        
        if let tickerId = tickerId {
            parameters = [.ticker: tickerId]
        } else {
            parameters = nil
        }
        
        logger.logView(parameters: parameters)
    }
    
    func trackUserTickerAppended(tickerId: String) {
        logger.logEvent(
            name: .userTickerAppended,
            parameters: [.ticker: tickerId]
        )
    }
    
    func trackUserTickerDeleted(tickerId: String) {
        logger.logEvent(
            name: .userTickerDeleted,
            parameters: [.ticker: tickerId]
        )
    }

    func trackUserTickersRefreshed(tickerIds: [String]) {
        logger.logEvent(
            name: .userTickersRefreshed,
            parameters: [.tickers: tickerIds.string]
        )
    }
    
    func trackUserTickersRefreshingFailed(tickerIds: [String]) {
        logger.logEvent(
            name: .userTickersRefreshingFailed,
            parameters: [.tickers: tickerIds.string]
        )
    }

    func trackReviewRequested() {
        logger.logEvent(
            name: .reviewRequested,
            parameters: nil
        )
    }
    
}

private extension Array where Element == String {
    
    var string: String { joined(separator: ",") }
    
}
