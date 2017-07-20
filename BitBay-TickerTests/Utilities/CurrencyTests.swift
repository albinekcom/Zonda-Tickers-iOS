import XCTest
@testable import BitBay_Ticker

final class CurrencyTests: XCTestCase {
    
    func testEnumRawValues() {
        XCTAssertEqual("PLN", Currency.pln.rawValue)
        XCTAssertEqual("USD", Currency.usd.rawValue)
        XCTAssertEqual("EUR", Currency.eur.rawValue)
        
        XCTAssertEqual("BTC", Currency.btc.rawValue)
        XCTAssertEqual("ETH", Currency.eth.rawValue)
        XCTAssertEqual("LTC", Currency.ltc.rawValue)
        XCTAssertEqual("LSK", Currency.lsk.rawValue)
    }
    
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
    
}
