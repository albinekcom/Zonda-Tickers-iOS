import XCTest
@testable import Zonda_Tickers

final class AppArgumentsTests: XCTestCase {
    
    func test_isUITest() {
        XCTAssertFalse(AppArguments(arguments: []).isUITest)
        XCTAssertTrue(AppArguments(arguments: [AppArguments.uiTestsKey]).isUITest)
    }
    
    func test_isTickerFetcherThrowingError() {
        XCTAssertFalse(AppArguments(arguments: []).isTickerFetcherThrowingError)
        XCTAssertTrue(AppArguments(arguments: [AppArguments.tickerFetcherThrowsErrorKey]).isTickerFetcherThrowingError)
    }
    
}
