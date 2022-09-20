import StoreKit
import XCTest
@testable import Zonda_Tickers

final class ReviewControllerTests: XCTestCase {
    
    private var sut: ReviewController!
    
    private var analyticsServiceLoggerSpy: AnalyticsServiceLoggerSpy!
    private var storeReviewControllerType = SKStoreReviewController.Spy.self
    
    // MARK: - Setting Up
    
    override func setUp() {
        super.setUp()
        
        UserDefaults.standard.set(0, forKey: ReviewController.counterKey)
        
        storeReviewControllerType.requestReviewInvoked = false
        analyticsServiceLoggerSpy = .init()
        
        sut = .init(
            analyticsService: .init(logger: analyticsServiceLoggerSpy),
            storeReviewControllerType: storeReviewControllerType
        )
    }
    
    // MARK: - Tests
    
    func test_tryToDisplay_notEnoughInvokeCount() {
        invokeTryToDisplay(count: ReviewController.counterMaximum - 1)
        
        XCTAssertFalse(storeReviewControllerType.requestReviewInvoked)
        analyticsServiceLoggerSpy.assert(expectedLoggedEvents: [])
    }
    
    func test_tryToDisplay_enoughInvokeCount() {
        invokeTryToDisplay(count: ReviewController.counterMaximum)
        
        XCTAssertTrue(storeReviewControllerType.requestReviewInvoked)
        analyticsServiceLoggerSpy.assert(expectedLoggedEvents: [(.reviewRequested, nil)])
    }
    
    func test_tryToDisplay_disabled() {
        sut.isEnabled = false
        
        invokeTryToDisplay(count: ReviewController.counterMaximum)
        
        XCTAssertFalse(storeReviewControllerType.requestReviewInvoked)
        analyticsServiceLoggerSpy.assert(expectedLoggedEvents: [])
    }
    
    private func invokeTryToDisplay(count: Int) {
        (1...count).forEach { _ in sut.tryToDisplay() }
    }
    
}

// MARK: - Helpers

private extension SKStoreReviewController {
    
    final class Spy: SKStoreReviewController {
        
        static var requestReviewInvoked = false
    
        override class func requestReview(in windowScene: UIWindowScene) {
            requestReviewInvoked = true
        }
        
    }
    
}
