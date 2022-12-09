import XCTest
@testable import Zonda_Tickers

final class StringArray_UserTickersTests: XCTestCase {

    func test_userTickers() {
        assert(expectedTickers: [.stub1, .stub2], userTickerIds: ["btc-pln", "eth-usd"])
        assert(expectedTickers: [.stub2, .stub1], userTickerIds: ["eth-usd", "btc-pln"])
        assert(expectedTickers: [.stub1], userTickerIds: ["btc-pln"])
        assert(expectedTickers: [.stub1, .init(id: "xxx-zzz")!, .stub2], userTickerIds: ["btc-pln", "xxx-zzz", "eth-usd"])
    }
    
    private func assert(
        expectedTickers: [Ticker],
        userTickerIds: [String]
    ) {
        XCTAssertEqual(expectedTickers, userTickerIds.userTickers(from: [.stub1, .stub2]))
    }

}
