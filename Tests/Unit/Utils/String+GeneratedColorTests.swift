import SwiftUI
import XCTest
@testable import Zonda_Tickers

final class String_GeneratedColorTests: XCTestCase {
    
    func test_generatedColor() {
        XCTAssertEqual(
            .init(
                red: 0.51236545390484267,
                green: 0.20070210212655012,
                blue: 0.16088291218392958
            ),
            "btc".generatedColor
        )
        
        XCTAssertEqual(
            .init(
                red: 0.094450311577295664,
                green: 0.45222290495223944,
                blue: 0.23734110927097907
            ),
            "BTC".generatedColor
        )
    }
    
}
