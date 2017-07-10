import XCTest
@testable import BitBay_Ticker

final class TextFactoryTests: XCTestCase {
    
    func testMakeLastUpdateDateText() {
        let updateDate = Date(timeIntervalSinceReferenceDate: 0)
        
        let lastUpdateText = TextFactory.makeLastUpdateDateText(updateDate: updateDate)
        
        XCTAssertEqual("Last Updated on January 1, 2001 at 1:00 AM", lastUpdateText)
    }
    
}
