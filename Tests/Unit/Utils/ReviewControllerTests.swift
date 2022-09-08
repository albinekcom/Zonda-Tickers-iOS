import StoreKit
import XCTest
@testable import Zonda_Tickers

final class ReviewControllerTests: XCTestCase {
    
    private var sut: ReviewController!
    
    private var analyticsService: AnalyticsServiceSpy!
    private var storeReviewControllerType = SKStoreReviewController.Spy.self
    
    override func setUp() {
        super.setUp()
        
        UserDefaults.standard.set(0, forKey: ReviewController.counterKey)
        
        storeReviewControllerType.requestReviewInvoked = false
        analyticsService = AnalyticsServiceSpy()
        
        sut = .init(
            analyticsService: analyticsService,
            storeReviewControllerType: storeReviewControllerType
        )
    }
    
    // MARK: - Tests
    
    func test_tryToDisplay_notEnoughInvokeCount() {
        invokeTryToDisplay(count: ReviewController.counterMaximum - 1)
        
        XCTAssertFalse(storeReviewControllerType.requestReviewInvoked)
        XCTAssertFalse(analyticsService.trackReviewRequestedInvoked)
    }
    
    func test_tryToDisplay_enoughInvokeCount() {
        invokeTryToDisplay(count: ReviewController.counterMaximum)
        
        XCTAssertTrue(storeReviewControllerType.requestReviewInvoked)
        XCTAssertTrue(analyticsService.trackReviewRequestedInvoked)
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
