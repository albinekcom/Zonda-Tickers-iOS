import SwiftUI
import XCTest
@testable import Zonda_Tickers

final class StringColorStyleTests: XCTestCase {
    
    func test_color() {
        XCTAssertEqual(.red, StringColorStyle.negative.color)
        XCTAssertEqual(.orange, StringColorStyle.neutral.color)
        XCTAssertEqual(.secondary, StringColorStyle.normal.color)
        XCTAssertEqual(.green, StringColorStyle.positive.color)
    }
    
}
