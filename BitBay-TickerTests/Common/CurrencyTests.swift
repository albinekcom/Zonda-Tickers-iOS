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
        XCTAssertFalse(Currency.xrp.isFiat)
        XCTAssertFalse(Currency.xin.isFiat)
        XCTAssertFalse(Currency.xmr.isFiat)
        XCTAssertFalse(Currency.zec.isFiat)
        XCTAssertFalse(Currency.gnt.isFiat)
        XCTAssertFalse(Currency.omg.isFiat)
        XCTAssertFalse(Currency.fto.isFiat)
        XCTAssertFalse(Currency.rep.isFiat)
        XCTAssertFalse(Currency.bat.isFiat)
        XCTAssertFalse(Currency.zrx.isFiat)
        XCTAssertFalse(Currency.pay.isFiat)
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
        XCTAssertEqual("XRP", Currency.xrp.description)
        XCTAssertEqual("XIN", Currency.xin.description)
        XCTAssertEqual("XMR", Currency.xmr.description)
        XCTAssertEqual("ZEC", Currency.zec.description)
        XCTAssertEqual("GNT", Currency.gnt.description)
        XCTAssertEqual("OMG", Currency.omg.description)
        XCTAssertEqual("FTO", Currency.fto.description)
        XCTAssertEqual("REP", Currency.rep.description)
        XCTAssertEqual("BAT", Currency.bat.description)
        XCTAssertEqual("ZRX", Currency.zrx.description)
        XCTAssertEqual("PAY", Currency.pay.description)
    }
    
}
