import XCTest
@testable import BitBay_Ticker

final class TickerTests: XCTestCase {
    
    func testTitle() {
        let ticker = Ticker(id: "BTC-PLN")
        
        XCTAssertEqual(ticker.title, "BTC/PLN")
    }
    
}
