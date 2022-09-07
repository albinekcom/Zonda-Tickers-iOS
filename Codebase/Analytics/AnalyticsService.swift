import Firebase

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
    
    private let analyticsType: Analytics.Type
    
    // MARK: - Initializing
    
    convenience init() {
        self.init(
            firebaseAppType: FirebaseApp.self,
            analyticsType: Analytics.self
        )
    }
    
    init(
        firebaseAppType: FirebaseApp.Type,
        analyticsType: Analytics.Type
    ) {
        self.analyticsType = analyticsType
        
        firebaseAppType.configure()
    }
    
    // MARK: - Tracks
    
    // MARK: Views
    
    func trackView(tickerId: String? = nil) {
        let parameters: [Track.ParameterKey: String]?
        
        if let tickerId = tickerId {
            parameters = [.ticker: tickerId]
        } else {
            parameters = nil
        }
        
        analyticsType.logEvent(
            AnalyticsEventScreenView,
            parameters: parameters?.analyticsParameters
        )
    }
    
    // MARK: Managing Tickers
    
    func trackUserTickerAppended(tickerId: String) {
        trackAction(
            .userTickerAppended,
            parameters: [.ticker: tickerId]
        )
    }
    
    func trackUserTickerDeleted(tickerId: String) {
        trackAction(
            .userTickerDeleted,
            parameters: [.ticker: tickerId]
        )
    }
    
    // MARK: Refreshing Tickers

    func trackUserTickersRefreshed(tickerIds: [String]) {
        trackAction(
            .userTickersRefreshed,
            parameters: [.tickers: tickerIds.string]
        )
    }
    
    func trackUserTickersRefreshingFailed(tickerIds: [String]) {
        trackAction(
            .userTickersRefreshingFailed,
            parameters: [.tickers: tickerIds.string]
        )
    }
    
    // MARK: Review

    func trackReviewRequested() {
        trackAction(.reviewRequested)
    }
    
    // MARK: - Helpers
    
    private func trackAction(
        _ name: Track.Name,
        parameters: [Track.ParameterKey: String]? = nil
    ) {
        analyticsType.logEvent(
            name.rawValue,
            parameters: parameters?.analyticsParameters
        )
    }
    
}

private extension Array where Element == String {
    
    var string: String { joined(separator: ",") }
    
}

private extension Dictionary where Key == AnalyticsService.Track.ParameterKey, Value == String {
    
    var analyticsParameters: [String: Any] {
        reduce(into: [String: String]()) { $0[$1.key.rawValue] = $1.value }
    }
    
}
