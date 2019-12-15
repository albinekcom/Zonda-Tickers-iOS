import XCTest
@testable import BitBay_Ticker

final class PrettyValueFormatterTests: XCTestCase {
    
    func testNilValue() {
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: nil, scale: 2, currency: nil), "-")
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: nil, scale: 2, currency: "PLN"), "- PLN")
    }
    
    func testScales() {
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: 1234.5678, scale: nil, currency: nil), "1,234.5678")
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: 1234.5678, scale: 0, currency: nil), "1,234")
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: 1234.5678, scale: 1, currency: nil), "1,234.5")
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: 1234.5678, scale: 2, currency: nil), "1,234.56")
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: 1234.5678, scale: 3, currency: nil), "1,234.567")
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: 1234.5678, scale: 4, currency: nil), "1,234.5678")
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: 1234.5678, scale: 5, currency: nil), "1,234.56780")
    }
    
    func testAppendingCurrency() {
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: 1234.5678, scale: nil, currency: nil), "1,234.5678")
        XCTAssertEqual(PrettyValueFormatter.makePrettyString(value: 1234.5678, scale: nil, currency: "BTC"), "1,234.5678 BTC")
    }
    
}
