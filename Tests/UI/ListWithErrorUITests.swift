import XCTest

final class ListWithErrorUITests: UITests {
    
    override var launchArguments: [String] {
        super.launchArguments + [AppArguments.tickerFetcherThrowsErrorKey]
    }
    
    // MARK: - Tests
    
    func test_displaying_error() {
        XCTAssertTrue(application.staticTexts["ERROR"].exists)
    }
    
}
