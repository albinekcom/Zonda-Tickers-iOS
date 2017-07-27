import XCTest
@testable import BitBay_Ticker

final class TickerTests: XCTestCase {
    
    func testKeys() {
        XCTAssertEqual("name", Ticker.Key.name)
        XCTAssertEqual("max", Ticker.Key.max)
        XCTAssertEqual("min", Ticker.Key.min)
        XCTAssertEqual("last", Ticker.Key.last)
        XCTAssertEqual("bid", Ticker.Key.bid)
        XCTAssertEqual("ask", Ticker.Key.ask)
        XCTAssertEqual("vwap", Ticker.Key.vwap)
        XCTAssertEqual("average", Ticker.Key.average)
        XCTAssertEqual("volume", Ticker.Key.volume)
    }
    
    func testInitWithName() {
        let ticker = Ticker(name: .btcpln, jsonDictionary: nil)!
        
        XCTAssertEqual(Ticker.Name.btcpln, ticker.name)
        XCTAssertEqual(Currency.btc, ticker.baseCurrency)
        XCTAssertEqual(Currency.pln, ticker.counterCurrency)
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
        
        let ticker = Ticker(name: .btcpln, jsonDictionary: jsonDictionary)!
        
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
    
    func testInitFromDictionary() {
        let inputDictionary: [String: Any] = [
            "max": 1.1,
            "min": 2.2,
            "last": 3.3,
            "bid": 4.4,
            "ask": 5.5,
            "vwap": 6.6,
            "average": 7.7,
            "volume": 8.8,
            "name": "btcpln"
        ]
        
        let ticker = Ticker(fromDictionary: inputDictionary)!
        
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
    
    func testDictionary() {
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
        
        let ticker = Ticker(name: .btcpln, jsonDictionary: jsonDictionary)!
        
        let expectedDictionary: [String: Any] = [
            "max": 1.1,
            "min": 2.2,
            "last": 3.3,
            "bid": 4.4,
            "ask": 5.5,
            "vwap": 6.6,
            "average": 7.7,
            "volume": 8.8,
            "name": "btcpln"
        ]
        
        XCTAssertEqual(expectedDictionary as NSDictionary, ticker.dictionary as NSDictionary)
    }
    
}
