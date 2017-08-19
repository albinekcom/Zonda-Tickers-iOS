import XCTest
@testable import BitBay_Ticker

final class TrendViewValueStringFactoryTests: XCTestCase {
    
    func testMakeValueString() {
        let factory = TrendViewValueStringFactory.self
        
        XCTAssertEqual("-", factory.makeValueString(from: nil))
        XCTAssertEqual("+0.00%", factory.makeValueString(from: 0.0))
        XCTAssertEqual("+2.30%", factory.makeValueString(from: 2.3))
        XCTAssertEqual("-2.30%", factory.makeValueString(from: -2.3))
        
        XCTAssertEqual("+12.3%", factory.makeValueString(from: 12.3))
        XCTAssertEqual("+123%", factory.makeValueString(from: 123.4))
        XCTAssertEqual("+999%", factory.makeValueString(from: 1234))
        
        XCTAssertEqual("+0.23%", factory.makeValueString(from: 0.23))
        XCTAssertEqual("+0.02%", factory.makeValueString(from: 0.023))
        XCTAssertEqual("+0.01%", factory.makeValueString(from: 0.0023))
        
        XCTAssertEqual("-12.3%", factory.makeValueString(from: -12.3))
        XCTAssertEqual("-123%", factory.makeValueString(from: -123.4))
        XCTAssertEqual("-999%", factory.makeValueString(from: -1234))
        
        XCTAssertEqual("-0.23%", factory.makeValueString(from: -0.23))
        XCTAssertEqual("-0.02%", factory.makeValueString(from: -0.023))
        XCTAssertEqual("-0.01%", factory.makeValueString(from: -0.0023))
    }
    
}
