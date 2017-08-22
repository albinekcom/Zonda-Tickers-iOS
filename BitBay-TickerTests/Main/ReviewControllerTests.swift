import XCTest
@testable import BitBay_Ticker

final class ReviewControllerTests: XCTestCase {
    
    let userDefaultsSuiteName = "TestDefaults"
    var reviewController: ReviewController!
    
    // MARK: - Setting
    
    override func setUp() {
        super.setUp()
        
        reviewController = ReviewController(userDefaults: UserDefaults(suiteName: userDefaultsSuiteName)!)
    }
    
    // MARK: - Tearing
    
    override func tearDown() {
        UserDefaults().removePersistentDomain(forName: userDefaultsSuiteName)
        
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testIncrementSuccessfulRefreshCount() {
        XCTAssertEqual(0, reviewController.successfulRefreshCount)
        
        reviewController.incrementSuccessfulRefreshCount()
        
        XCTAssertEqual(1, reviewController.successfulRefreshCount)
    }
    
    func testClearSuccessfulRefreshCount() {
        XCTAssertEqual(0, reviewController.successfulRefreshCount)
        
        reviewController.incrementSuccessfulRefreshCount()
        
        XCTAssertEqual(1, reviewController.successfulRefreshCount)
        
        reviewController.clearSuccessfulRefreshCount()
        
        XCTAssertEqual(0, reviewController.successfulRefreshCount)
    }
    
    func testShouldDisplayReviewController() {
        XCTAssertFalse(reviewController.shouldDisplayReviewController)
        
        reviewController.incrementSuccessfulRefreshCount()
        XCTAssertFalse(reviewController.shouldDisplayReviewController)
        
        reviewController.incrementSuccessfulRefreshCount()
        XCTAssertFalse(reviewController.shouldDisplayReviewController)
        
        reviewController.incrementSuccessfulRefreshCount()
        XCTAssertFalse(reviewController.shouldDisplayReviewController)
        
        reviewController.incrementSuccessfulRefreshCount()
        XCTAssertFalse(reviewController.shouldDisplayReviewController)
        
        reviewController.incrementSuccessfulRefreshCount()
        XCTAssertTrue(reviewController.shouldDisplayReviewController)
        
        reviewController.incrementSuccessfulRefreshCount()
        XCTAssertTrue(reviewController.shouldDisplayReviewController)
        
        reviewController.clearSuccessfulRefreshCount()
        XCTAssertFalse(reviewController.shouldDisplayReviewController)
    }
    
}
