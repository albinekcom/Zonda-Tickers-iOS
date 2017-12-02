import XCTest
@testable import BitBay_Ticker

final class AddTickerViewModelTests: XCTestCase {
    
    func testName() {
        XCTAssertEqual("BTC/EUR", AddTickerViewModel(tickerName: .btceur).name)
        XCTAssertEqual("LSK/BTC", AddTickerViewModel(tickerName: .lskbtc).name)
        XCTAssertEqual("DASH/PLN", AddTickerViewModel(tickerName: .dashpln).name)
    }
    
}
