import XCTest
@testable import BitBay_Ticker

final class CurrencyTests: XCTestCase {
    
    func testFiatCurrencies() {
        XCTAssertEqual([Currency.pln, Currency.usd, Currency.eur], Currency.fiatCurrencies)
    }
    
    func testIsFiat() {
        XCTAssertTrue(Currency.pln.isFiat)
        XCTAssertTrue(Currency.usd.isFiat)
        XCTAssertTrue(Currency.eur.isFiat)
        
        XCTAssertFalse(Currency.btc.isFiat)
        XCTAssertFalse(Currency.eth.isFiat)
        XCTAssertFalse(Currency.ltc.isFiat)
        XCTAssertFalse(Currency.lsk.isFiat)
    }
    
    func testDescription() {
        XCTAssertEqual("PLN", Currency.pln.description)
        XCTAssertEqual("USD", Currency.usd.description)
        XCTAssertEqual("EUR", Currency.eur.description)
        
        XCTAssertEqual("BTC", Currency.btc.description)
        XCTAssertEqual("ETH", Currency.eth.description)
        XCTAssertEqual("LTC", Currency.ltc.description)
        XCTAssertEqual("LSK", Currency.lsk.description)
    }
    
}
