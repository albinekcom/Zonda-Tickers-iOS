import XCTest
@testable import Zonda_Tickers

final class TickerTests: XCTestCase {
    
    func test_id() {
        XCTAssertEqual("btc-pln", Ticker.stub.id)
    }
    
    func test_change() {
        XCTAssertEqual(-5, Ticker.stub.change)
    }
    
    func test_changeRatio() {
        XCTAssertEqual(-0.625, Ticker.stub.changeRatio)
    }
    
    func test_volumeValue() {
        XCTAssertEqual(21, Ticker.stub.volumeValue)
    }
    
    func test_tags() {
        XCTAssertEqual(["btc-pln", "btc", "pln", "btcpln", "btc\\pln", "bitcoin", "złoty"], Ticker.stub.tags)
    }
    
    func test_comparable() {
        XCTAssertTrue(Ticker.stub < Ticker.stub2)
    }
    
    func test_init_from_id() {
        XCTAssertNil(Ticker(id: "btcpln"))
        XCTAssertNil(Ticker(id: "btc-"))
        XCTAssertNil(Ticker(id: "-pln"))
        XCTAssertNotNil(Ticker(id: "btc-pln"))
    }

}
