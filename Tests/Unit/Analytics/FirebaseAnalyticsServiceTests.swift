import Firebase
import XCTest
@testable import Zonda_Tickers

final class FirebaseAnalyticsServiceTests: XCTestCase {
    
    private var sut: FirebaseAnalyticsService!
    
    private let firebaseConfigurableSpyType = FirebaseConfigurableSpy.self
    private let analyticsSpyType = Analytics.Spy.self
    
    // MARK: - Setting Up
    
    override func setUp() {
        super.setUp()
        
        firebaseConfigurableSpyType.isConfigured = false
        analyticsSpyType.loggedEvents = []
        
        sut = .init(
            firebaseConfigurableType: firebaseConfigurableSpyType,
            analyticsType: analyticsSpyType
        )
    }
    
    // MARK: - Tests
    
    func test_init() {
        XCTAssertTrue(firebaseConfigurableSpyType.isConfigured)
    }
    
    func test_trackView() {
        sut.trackView()
        sut.trackView(tickerId: "1")
        
        assert(expectedLoggedEvents: [
            .init(
                name: "screen_view",
                parameters: nil
            ),
            .init(
                name: "screen_view",
                parameters: ["Ticker": "1"]
            )
        ])
    }
    
    func test_trackUserTickerAppended() {
        sut.trackUserTickerAppended(tickerId: "1")
        
        assert(expectedLoggedEvents: [.init(
            name: "User_Ticker_Appended",
            parameters: ["Ticker": "1"]
        )])
    }
    
    func test_trackUserTickerDeleted() {
        sut.trackUserTickerDeleted(tickerId: "1")
        
        assert(expectedLoggedEvents: [.init(
            name: "User_Ticker_Deleted",
            parameters: ["Ticker": "1"]
        )])
    }
    
    func test_trackUserTickersRefreshed() {
        sut.trackUserTickersRefreshed(tickerIds: ["1", "2", "3", "4"])
        
        assert(expectedLoggedEvents: [.init(
            name: "User_Tickers_Refreshed",
            parameters: ["Tickers": "1,2,3,4"]
        )])
    }
    
    func test_trackUserTickersRefreshingFailed() {
        sut.trackUserTickersRefreshingFailed(tickerIds: ["1", "2", "3", "4"])
        
        assert(expectedLoggedEvents: [.init(
            name: "User_Tickers_Refreshing_Failed",
            parameters: ["Tickers": "1,2,3,4"]
        )])
    }
    
    func test_trackReviewRequested() {
        sut.trackReviewRequested()
        
        assert(expectedLoggedEvents: [.init(
            name: "Requested_Review",
            parameters: nil
        )])
    }
    
    private func assert(expectedLoggedEvents: [Analytics.Spy.LoggedEvent]) {
        XCTAssertEqual(expectedLoggedEvents, analyticsSpyType.loggedEvents)
    }

}

// MARK: - Helpers

private final class FirebaseConfigurableSpy: FirebaseConfigurable {
    
    static var isConfigured = false
    
    static func configure() {
        isConfigured = true
    }
    
}

private extension Analytics {
    
    final class Spy: Analytics {
        
        struct LoggedEvent: Equatable {
            
            let name: String
            let parameters: [String: String]?
            
        }
        
        static var loggedEvents: [LoggedEvent] = []
        
        override class func logEvent(_ name: String, parameters: [String: Any]?) {
            loggedEvents.append(.init(name: name, parameters: parameters as? [String: String]))
        }
        
    }
    
}
