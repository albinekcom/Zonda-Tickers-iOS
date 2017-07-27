import XCTest
import RxBlocking
@testable import BitBay_Ticker

final class TickerFactoryTests: XCTestCase {
    
    func testMakeObservableTicker() {
        let observableTicker = TickerFactory.makeObservableTicker(named: .btcpln)
        
        let results = try! observableTicker.toBlocking().toArray()
        
        XCTAssertEqual(1, results.count)
        
        let ticker = results.first!!
        
        XCTAssertNotNil(ticker)
        XCTAssertEqual(Ticker.Name.btcpln, ticker.name)
        XCTAssertEqual(Currency.btc, ticker.baseCurrency)
        XCTAssertEqual(Currency.pln, ticker.counterCurrency)
        XCTAssertEqual(1.1, ticker.max)
        XCTAssertEqual(2.2, ticker.min)
        XCTAssertEqual(3.3, ticker.last)
        XCTAssertEqual(4.4, ticker.bid)
        XCTAssertEqual(5.5, ticker.ask)
        XCTAssertEqual(6.6, ticker.vwap)
        XCTAssertEqual(7.7, ticker.average)
        XCTAssertEqual(8.8, ticker.volume)
    }
    
}
