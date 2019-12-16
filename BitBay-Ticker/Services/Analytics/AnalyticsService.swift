import Firebase

struct AnalyticsService {
    
    static var isEnabled: Bool = true
    static var showConsoleLogs: Bool = false
    
    // MARK: - States
    
    static func trackAddTickerView() {
        track(name: "Add_Ticker_View")
    }
    
    static func trackTickersView() {
        track(name: "Tickers_View")
    }
    
    static func trackTickerDetailsView(parameters: [String: String]) {
        track(name: "Ticker_Details_View", parameters: parameters)
    }
    
    static func trackEditTickersView() {
        track(name: "Edit_Tickers_View")
    }
    
    static func trackRequestedRatingView() {
        track(name: "Requested_Rating_View")
    }
    
    // MARK: - Actions
    
    static func trackAddedTicker(parameters: [String: String]) {
        track(name: "Added_Ticker", parameters: parameters)
    }
    
    static func trackRemovedTicker(parameters: [String: String]) {
        track(name: "Removed_Ticker", parameters: parameters)
    }
    
    static func trackRefreshedTickers(parameters: [String: String]) {
        track(name: "Refreshed_Tickers", parameters: parameters)
    }
    
    // MARK: - Tracking
    
    private static func track(name: String, parameters: [String: String]? = nil) {
        if isEnabled {
            Analytics.logEvent(name, parameters: parameters)
        }
        
        if showConsoleLogs {
            print("👣 [TRACKED] \"\(name)\" | Parameters: \(String(describing: parameters))")
        }
    }
    
}
