import Foundation

final class AnalyticsService {
    
    enum TrackType: String {
        case state
        case action
    }
    
    static let shared = AnalyticsService()
    
    #if DEBUG
        private let isEnabled = false
        private let isLoggingEnabled = true
    #else
        private let isEnabled = true
        private let isLoggingEnabled = false
    #endif
    
    private func track(type: TrackType, title: String, parameters: [String: Any]? = nil) {
        if isEnabled {
            // TODO: Fill this method using external analytics service
        }
        
        if isLoggingEnabled {
            print("[TRACKED] (\(type.rawValue.uppercased())) \"\(title)\" | Parameters: \(String(describing: parameters))")
        }
    }
    
    // MARK: - States
    
    func trackAddTickerView() {
        track(type: .state, title: "Add Ticker View")
    }
    
    func trackTickersView() {
        track(type: .state, title: "Tickers View")
    }
    
    func trackTickerDetailsView(parameters: [String: Any]) {
        track(type: .state, title: "Tickers View", parameters: parameters)
    }
    
    func trackEditTickersView() {
        track(type: .state, title: "Edit Tickers View")
    }
    
    // MARK: - Actions
    
    func trackAddedTicker(parameters: [String: Any]) {
        track(type: .action, title: "Added Ticker", parameters: parameters)
    }
    
    func trackRemovedTicker(parameters: [String: Any]) {
        track(type: .action, title: "Removed Ticker", parameters: parameters)
    }
    
    func trackRefreshedTickers(parameters: [String: Any]) {
        track(type: .action, title: "Refreshed Tickers", parameters: parameters)
    }
    
}
