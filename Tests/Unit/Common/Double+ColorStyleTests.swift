import XCTest
@testable import Zonda_Tickers

final class Double_ColorTests: XCTestCase {
    
    func test_color() {
        XCTAssertEqual(0.color, .orange)
        XCTAssertEqual(1.color, .green)
        XCTAssertEqual((-1).color, .red)
    }
    
}
