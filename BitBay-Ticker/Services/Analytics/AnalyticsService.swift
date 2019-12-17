import Firebase

struct AnalyticsService {
    
    static var isTrackingEnabled: Bool = false
    static var shouldPrintConsoleLog: Bool = true
    
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
    
    static func trackEditTickersView() { // TODO: Invoke this method at a proper place
        track(name: "Edit_Tickers_View")
    }
    
    static func trackRequestedRatingView() { // TODO: Invoke this method at a proper place
        track(name: "Requested_Rating_View")
    }
    
    // MARK: - Actions
    
    static func trackAddedTicker(parameters: [String: String]) { // TODO: Invoke this method at a proper place
        track(name: "Added_Ticker", parameters: parameters)
    }
    
    static func trackRemovedTicker(parameters: [String: String]) { // TODO: Invoke this method at a proper place
        track(name: "Removed_Ticker", parameters: parameters)
    }
    
    static func trackRefreshedTickers(parameters: [String: String]) { // TODO: Invoke this method at a proper place
        track(name: "Refreshed_Tickers", parameters: parameters)
    }
    
    // MARK: - Tracking
    
    private static func track(name: String, parameters: [String: String]? = nil) {
        trackIfEnabled(name: name, parameters: parameters)
        printConsoleLogIfEnabled(name: name, parameters: parameters)
    }
    
    private static func trackIfEnabled(name: String, parameters: [String: String]? = nil) {
        guard isTrackingEnabled else { return }
        
        Analytics.logEvent(name, parameters: parameters)
    }
    
    private static func printConsoleLogIfEnabled(name: String, parameters: [String: String]? = nil) {
        guard shouldPrintConsoleLog else { return }
        
        var description = "👣 [TRACKED] \"\(name)\""
        
        if let parameters = parameters {
            description += " with parameters: \(String(describing: parameters))"
        }
        
        print(description)
    }
    
}
