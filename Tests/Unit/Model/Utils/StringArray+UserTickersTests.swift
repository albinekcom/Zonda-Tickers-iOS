import XCTest
@testable import Zonda_Tickers

final class StringArray_UserTickersTests: XCTestCase {

    func test_userTickers() {
        assert(expectedTickers: [.stub1, .stub2], userTickersId: ["btc-pln", "eth-usd"])
        assert(expectedTickers: [.stub2, .stub1], userTickersId: ["eth-usd", "btc-pln"])
        assert(expectedTickers: [.stub1], userTickersId: ["btc-pln"])
        assert(expectedTickers: [.stub1, .init(id: "xxx-zzz")!, .stub2], userTickersId: ["btc-pln", "xxx-zzz", "eth-usd"])
    }
    
    private func assert(
        expectedTickers: [Ticker],
        userTickersId: [String]
    ) {
        XCTAssertEqual(expectedTickers, userTickersId.userTickers(from: [.stub1, .stub2]))
    }

}
