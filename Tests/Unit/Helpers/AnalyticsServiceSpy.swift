@testable import Zonda_Tickers

final class AnalyticsServiceSpy: AnalyticsService {
    
    private(set) var trackViewInvoked = false
    private(set) var trackUserTickerAppendedInvoked = false
    private(set) var trackUserTickerDeletedInvoked = false
    private(set) var trackUserTickersRefreshedInvoked = false
    private(set) var trackUserTickersRefreshingFailedInvoked = false
    private(set) var trackReviewRequestedInvoked = false
    
    func trackView(tickerId: String?) {
        trackViewInvoked = true
    }
    
    func trackUserTickerAppended(tickerId: String) {
        trackUserTickerAppendedInvoked = true
    }
    
    func trackUserTickerDeleted(tickerId: String) {
        trackUserTickerDeletedInvoked = true
    }
    
    func trackUserTickersRefreshed(tickerIds: [String]) {
        trackUserTickersRefreshedInvoked = true
    }
    
    func trackUserTickersRefreshingFailed(tickerIds: [String]) {
        trackUserTickersRefreshingFailedInvoked = true
    }
    
    func trackReviewRequested() {
        trackReviewRequestedInvoked = true
    }
    
}
