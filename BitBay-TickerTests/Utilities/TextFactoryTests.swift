import XCTest
@testable import BitBay_Ticker

final class TextFactoryTests: XCTestCase {
    
    func testMakeLastUpdateDateText() {
        let updateDate = Date(timeIntervalSinceReferenceDate: 0)
        let timeZone = TimeZone(abbreviation: "UTC")
        
        let lastUpdateText = TextFactory.makeLastUpdateDateText(updateDate: updateDate, timeZone: timeZone)
        
        XCTAssertEqual("Last Updated on January 1, 2001 at 12:00 AM", lastUpdateText)
    }
    
}
