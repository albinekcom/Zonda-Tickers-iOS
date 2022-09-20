import Firebase
import XCTest
@testable import Zonda_Tickers

final class AnalyticsServiceFirebaseLoggerTests: XCTestCase {
    
    private var sut: AnalyticsServiceFirebaseLogger!
    
    private let analyticsSpyType = Analytics.Spy.self
    
    // MARK: - Setting Up
    
    override func setUp() {
        super.setUp()
        
        analyticsSpyType.loggedEvents = []
        
        sut = .init(analyticsType: analyticsSpyType)
    }
    
    // MARK: - Tests
    
    func test_logView() {
        sut.logView()
        sut.logView(parameters: [.ticker: "1"])
        
        assert(expectedLoggedEvents: [
            ("screen_view", nil),
            ("screen_view", ["Ticker": "1"])
        ])
    }
    
    func test_logEvent() {
        sut.logEvent(
            name: .userTickersRefreshed,
            parameters: [.tickers: "1,2,3,4"]
        )
        
        assert(expectedLoggedEvents: [("User_Tickers_Refreshed", ["Tickers": "1,2,3,4"])])
    }
    
    private func assert(expectedLoggedEvents: [(String, [String: Any]?)]) {
        XCTAssertEqual(expectedLoggedEvents.count, analyticsSpyType.loggedEvents.count)
        
        for (index, expectedValue) in expectedLoggedEvents.enumerated() {
            XCTAssertEqual(expectedValue.0, analyticsSpyType.loggedEvents[index].0)
            XCTAssertEqual(expectedValue.1 as? [String: String], analyticsSpyType.loggedEvents[index].1 as? [String: String])
        }
    }
    
}

// MARK: - Helpers

private extension Analytics {
    
    final class Spy: Analytics {
        
        static var loggedEvents: [(String, [String: Any]?)] = []
        
        override class func logEvent(_ name: String, parameters: [String: Any]?) {
            loggedEvents.append((name, parameters))
        }
        
    }
    
}
