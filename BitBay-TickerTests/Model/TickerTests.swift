import XCTest
@testable import BitBay_Ticker

final class TickerTests: XCTestCase {
    
    func testInitWithName() {
        let ticker = Ticker(name: .btcpln, jsonDictionary: nil)
        
        XCTAssertEqual(Ticker.Name.btcpln, ticker.name)
        XCTAssertEqual("BTC", ticker.baseCurrency)
        XCTAssertEqual("PLN", ticker.counterCurrency)
        XCTAssertNil(ticker.max)
        XCTAssertNil(ticker.min)
        XCTAssertNil(ticker.last)
        XCTAssertNil(ticker.bid)
        XCTAssertNil(ticker.ask)
        XCTAssertNil(ticker.vwap)
        XCTAssertNil(ticker.average)
        XCTAssertNil(ticker.volume)
    }
    
    func testInitWithNameAndJsonDictionary() {
        let jsonDictionary = [
            "max": 1.1,
            "min": 2.2,
            "last": 3.3,
            "bid": 4.4,
            "ask": 5.5,
            "vwap": 6.6,
            "average": 7.7,
            "volume": 8.8
        ]
        
        let ticker = Ticker(name: .btcpln, jsonDictionary: jsonDictionary)
        
        XCTAssertEqual(Ticker.Name.btcpln, ticker.name)
        XCTAssertEqual("BTC", ticker.baseCurrency)
        XCTAssertEqual("PLN", ticker.counterCurrency)
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
