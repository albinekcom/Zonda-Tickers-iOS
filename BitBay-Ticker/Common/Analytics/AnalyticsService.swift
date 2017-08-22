import Crashlytics
import Foundation

struct AnalyticsService {
    
    #if DEBUG
        private static let isEnabled = false
        private static let isLoggingEnabled = true
    #else
        private static let isEnabled = true
        private static let isLoggingEnabled = false
    #endif
    
    private static func track(name: String, parameters: [String: String]? = nil) {
        if isEnabled {
            Answers.logCustomEvent(withName: name, customAttributes: parameters)
        }
        
        if isLoggingEnabled {
            print("[TRACKED] \"\(name)\" | Parameters: \(String(describing: parameters))")
        }
    }
    
    // MARK: - States
    
    static func trackAddTickerView() {
        track(name: "Add Ticker View")
    }
    
    static func trackTickersView() {
        track(name: "Tickers View")
    }
    
    static func trackTickerDetailsView(parameters: [String: String]) {
        track(name: "Tickers View", parameters: parameters)
    }
    
    static func trackEditTickersView() {
        track(name: "Edit Tickers View")
    }
    
    static func trackRequestedRatingView() {
        track(name: "Requested Rating View")
    }
    
    // MARK: - Actions
    
    static func trackAddedTicker(parameters: [String: String]) {
        track(name: "Added Ticker", parameters: parameters)
    }
    
    static func trackRemovedTicker(parameters: [String: String]) {
        track(name: "Removed Ticker", parameters: parameters)
    }
    
    static func trackRefreshedTickers(parameters: [String: String]) {
        track(name: "Refreshed Tickers", parameters: parameters)
    }
    
    static func trackRefreshedTickersInvokedByUser(parameters: [String: String]) {
        track(name: "Refreshed Tickers Invoked By User", parameters: parameters)
    }
    
}
