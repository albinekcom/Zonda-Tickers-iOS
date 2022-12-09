import XCTest
@testable import Zonda_Tickers

final class TickerTests: XCTestCase {
    
    func test_id() {
        XCTAssertEqual("btc-pln", Ticker.stub1.id)
    }
    
    func test_change() {
        XCTAssertEqual(-5, Ticker.stub1.change)
    }
    
    func test_changeRatio() {
        XCTAssertEqual(-0.625, Ticker.stub1.changeRatio)
    }
    
    func test_volumeValue() {
        XCTAssertEqual(21, Ticker.stub1.volumeValue)
    }
    
    func test_tags() {
        XCTAssertEqual(["btc-pln", "btc", "pln", "btcpln", "btc\\pln", "bitcoin", "złoty"], Ticker.stub1.tags)
    }
    
    func test_comparable() {
        XCTAssertTrue(Ticker.stub1 < Ticker.stub2)
    }
    
    func test_init_from_id() {
        XCTAssertNil(Ticker(id: "btcpln"))
        XCTAssertNil(Ticker(id: "btc-"))
        XCTAssertNil(Ticker(id: "-pln"))
        XCTAssertNotNil(Ticker(id: "btc-pln"))
    }
    
    func test_jsonString() {
        let ticker = Ticker.stub1
        let tickerJsonString = ticker.jsonString!
        let decodedTicker = try! JSONDecoder().decode(Ticker.self, from: tickerJsonString.data(using: .utf8)!)
        
        XCTAssertEqual(ticker, decodedTicker)
    }

}
