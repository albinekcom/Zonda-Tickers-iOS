import Foundation

struct AppConfiguration {
    
    struct Endpoint {
        
        static let tickerIdentifiers: String = "https://raw.githubusercontent.com/albinekcom/BitBay-API-Tools/master/v1/available-tickers.json"
        static let tickerValues: String = "https://api.bitbay.net/rest/trading/ticker/"
        static let tickerStatistics: String = "https://api.bitbay.net/rest/trading/stats/"
        
    }
    
    struct Analytics {
        
        #if DEBUG
            static let isTrackingEnabled: Bool = false
            static let shouldPrintConsoleLog: Bool = true
        #else
            static let isTrackingEnabled: Bool = true
            static let shouldPrintConsoleLog: Bool = false
        #endif
        
    }
    
    struct UserData {
        
        static let timeSpanBetweenTickerRefreshes: TimeInterval = 5.seconds
        static let minimumTimeSpanBetweenTickerIndentifiersRefreshes: TimeInterval = 1.hours
        
    }
    
    struct Storing {
        
        static let sharedDefaultsIdentifier: String = "group.com.albinek.ios.BitBay-Ticker.shared.defaults"
        static let userDataTickersFileName: String = "user_data_tickers_v1"
        static let applicationLaunchCounterKey: String = "application_launch_counter"
        
    }
    
    static let displayRatingPopUpEveryXApplicationLaunchTimes: Int = 10
    
}
