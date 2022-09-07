import XCTest
@testable import Zonda_Tickers

final class Double_Pretty: XCTestCase {
    
    func test_pretty() {
        XCTAssertEqual("1.123", 1.123456.pretty(precision: nil))
        XCTAssertEqual("1.1235", 1.123456.pretty(precision: 4))
        XCTAssertEqual("^1.1235", 1.123456.pretty(precision: 4, positivePrefix: "^"))
        XCTAssertEqual("-1.1235", (-1.123456).pretty(precision: 4))
        XCTAssertEqual("^1.1235", (-1.123456).pretty(precision: 4, negativePrefix: "^"))
        XCTAssertEqual("112.3457%", 1.123456789.pretty(precision: 4, numberStyle: .percent))
    }
    
}
