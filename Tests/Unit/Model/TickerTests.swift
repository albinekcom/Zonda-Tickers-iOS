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

}

// MARK: - Helpers

private extension Ticker {
    
    static var stub: Self {
        .init(
            firstCurrency: .init(id: "btc", name: "Bitcoin", precision: 8),
            secondCurrency: .init(id: "pln", name: "Złoty", precision: 2),
            highestBid: 1,
            lowestAsk: 2,
            rate: 3,
            previousRate: 4,
            highestRate: 5,
            lowestRate: 6,
            volume: 7,
            average: 8
        )
    }
    
    static var stub2: Self {
        .init(
            firstCurrency: .init(id: "eth", name: "Ethereum", precision: 8),
            secondCurrency: .init(id: "usd", name: "Dollar", precision: 2),
            highestBid: 1,
            lowestAsk: 2,
            rate: 3,
            previousRate: 4,
            highestRate: 5,
            lowestRate: 6,
            volume: 7,
            average: 8
        )
    }
    
}
