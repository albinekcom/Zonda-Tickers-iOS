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
        XCTAssertFalse(Currency.bcc.isFiat)
        XCTAssertFalse(Currency.dash.isFiat)
        XCTAssertFalse(Currency.game.isFiat)
        XCTAssertFalse(Currency.btg.isFiat)
        XCTAssertFalse(Currency.kzc.isFiat)
    }
    
    func testDescription() {
        XCTAssertEqual("PLN", Currency.pln.description)
        XCTAssertEqual("USD", Currency.usd.description)
        XCTAssertEqual("EUR", Currency.eur.description)
        
        XCTAssertEqual("BTC", Currency.btc.description)
        XCTAssertEqual("ETH", Currency.eth.description)
        XCTAssertEqual("LTC", Currency.ltc.description)
        XCTAssertEqual("LSK", Currency.lsk.description)
        XCTAssertEqual("BCC", Currency.bcc.description)
        XCTAssertEqual("DASH", Currency.dash.description)
        XCTAssertEqual("GAME", Currency.game.description)
        XCTAssertEqual("BTG", Currency.btg.description)
        XCTAssertEqual("KZC", Currency.kzc.description)
    }
    
}
