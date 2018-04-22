import Crashlytics
import Foundation

struct AnalyticsService {
    
    private static var isEnabled: Bool {
        return !Environment.isDebug
    }
    
    private static var isLoggingEnabled: Bool {
        return Environment.isDebug
    }
    
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
        track(name: "Ticker Details View", parameters: parameters)
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
    
}
