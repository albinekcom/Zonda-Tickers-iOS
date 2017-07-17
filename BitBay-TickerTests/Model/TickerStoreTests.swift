import XCTest
@testable import BitBay_Ticker

final class TickerStoreTests: XCTestCase {
    
    // MARK: - Tests
    
    func testKeys() {
        XCTAssertEqual("tickers", TickerStore.Key.tickers)
        XCTAssertEqual("lastUpdateTimeIntervalSinceReferenceDate", TickerStore.Key.lastUpdateTimeIntervalSinceReferenceDate)
    }
    
    func testuserDataPlistName() {
        XCTAssertEqual("user_data", TickerStore.userDataPlistName)
    }
    
}
