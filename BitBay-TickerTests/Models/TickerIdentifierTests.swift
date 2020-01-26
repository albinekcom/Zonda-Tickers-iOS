import XCTest
@testable import BitBay_Ticker

final class TickerIdentifierTests: XCTestCase {
    
    func testFirstCurrencyIdetifier() {
        let tickerIdentifier = TickerIdentifier(id: "BTC-PLN")
        
        XCTAssertEqual(tickerIdentifier.firstCurrencyIdentifier, "BTC")
    }
    
    func testSecondCurrencyIdetifier() {
        let tickerIdentifier = TickerIdentifier(id: "BTC-PLN")
        
        XCTAssertEqual(tickerIdentifier.secondCurrencyIdentifier, "PLN")
    }
    
    func testPrettyTitle() {
        let tickerIdentifier = TickerIdentifier(id: "BTC-PLN")
        
        XCTAssertEqual(tickerIdentifier.prettyTitle, "BTC/PLN")
    }

}
