import XCTest
@testable import BitBay_Ticker

final class TickerStoreTests: XCTestCase {
    
    // MARK: - Tests
    
    func testKeys() {
        XCTAssertEqual("tickers", TickerStore.Key.tickers)
        XCTAssertEqual("lastUpdateTimeIntervalSinceReferenceDate", TickerStore.Key.lastUpdateTimeIntervalSinceReferenceDate)
    }
    
    func testUserDataPlistName() {
        XCTAssertEqual("user_data", TickerStore.userDataPlistName)
    }
    
    func testSharedDefaultsIdentifier() {
        XCTAssertEqual("group.com.albinek.ios.BitBay-Ticker.shared.defaults", TickerStore.sharedDefaultsIdentifier)
    }
    
    func testRefreshingType() {
        XCTAssertEqual("Automatic", TickerStore.RefreshingType.automatic.rawValue)
        XCTAssertEqual("User", TickerStore.RefreshingType.user.rawValue)
        XCTAssertEqual("Widget", TickerStore.RefreshingType.widget.rawValue)
    }
    
}
