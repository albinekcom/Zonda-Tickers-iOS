import XCTest
@testable import BitBay_Ticker

final class TextFactoryTests: XCTestCase {
    
    func testMakeLastUpdateDateText() {
        let updateDate = Date(timeIntervalSinceReferenceDate: 0)
        let timeZone = TimeZone(abbreviation: "UTC")
        
        let lastUpdateText = TextFactory.makeLastUpdateDateText(updateDate: updateDate, timeZone: timeZone)
        
        XCTAssertEqual("Last Updated on January 1, 2001 at 12:00 AM", lastUpdateText)
    }
    
    func testMakeFormattedCurrencyValueString() {
        XCTAssertEqual("1,234.5", TextFactory.makeFormattedCurrencyValueString(for: 1234.5, isFiat: false))
        XCTAssertEqual("1,234.50", TextFactory.makeFormattedCurrencyValueString(for: 1234.5, isFiat: true))
        
        XCTAssertEqual("1,234.56891", TextFactory.makeFormattedCurrencyValueString(for: 1234.56891, isFiat: false))
        XCTAssertEqual("1,234.57", TextFactory.makeFormattedCurrencyValueString(for: 1234.56891, isFiat: true))
        
        XCTAssertEqual("-", TextFactory.makeFormattedCurrencyValueString(for: nil, isFiat: false))
        XCTAssertEqual("-", TextFactory.makeFormattedCurrencyValueString(for: nil, isFiat: true))
    }
    
}
