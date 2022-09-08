protocol AnalyticsService {
    
    func trackView(tickerId: String?)
    func trackUserTickerAppended(tickerId: String)
    func trackUserTickerDeleted(tickerId: String)
    func trackUserTickersRefreshed(tickerIds: [String])
    func trackUserTickersRefreshingFailed(tickerIds: [String])
    func trackReviewRequested()
}
