import XCTest
@testable import Zonda_Tickers

final class Double_StringColorStyleTests: XCTestCase {
    
    func test_stringColorStyle() {
        verify(expectedStringColorStyle: .positive, for: 1.1)
        verify(expectedStringColorStyle: .negative, for: -1.1)
        verify(expectedStringColorStyle: .neutral, for: 0)
        verify(expectedStringColorStyle: .normal, for: nil)
    }
    
    private func verify(expectedStringColorStyle: StringColorStyle, for value: Double?) {
        XCTAssertEqual(expectedStringColorStyle, value.stringColorStyle)
    }
    
}
