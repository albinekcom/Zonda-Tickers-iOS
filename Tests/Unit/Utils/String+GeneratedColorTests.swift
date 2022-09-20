import SwiftUI
import XCTest
@testable import Zonda_Tickers

final class String_GeneratedColorTests: XCTestCase {
    
    func test_generatedBackgroundColor() {
        XCTAssertEqual(
            .init(
                red: 0.51236545390484267,
                green: 0.20070210212655012,
                blue: 0.16088291218392958
            ),
            "btc".generatedBackgroundColor
        )
        
        XCTAssertEqual(
            .init(
                red: 0.094450311577295664,
                green: 0.45222290495223944,
                blue: 0.23734110927097907
            ),
            "BTC".generatedBackgroundColor
        )
    }
    
    func test_generatedForegroundColor() {
        XCTAssertEqual(.white, "btc".generatedForegroundColor)
        XCTAssertEqual(.white, "BTC".generatedForegroundColor)
    }
    
    func test_optional_generatedBackgroundColor() {
        var optionalString: String?
        
        optionalString = "btc"
        XCTAssertEqual(
            .init(
                red: 0.51236545390484267,
                green: 0.20070210212655012,
                blue: 0.16088291218392958
            ),
            optionalString.generatedBackgroundColor
        )
        
        optionalString = "BTC"
        XCTAssertEqual(
            .init(
                red: 0.094450311577295664,
                green: 0.45222290495223944,
                blue: 0.23734110927097907
            ),
            optionalString.generatedBackgroundColor
        )
        
        optionalString = nil
        XCTAssertEqual(.gray, optionalString.generatedBackgroundColor)
    }
    
    func test_optional_generatedForegroundColor() {
        var optionalString: String?
        
        optionalString = "btc"
        XCTAssertEqual(.white, optionalString.generatedForegroundColor)
        
        optionalString = "BTC"
        XCTAssertEqual(.white, optionalString.generatedForegroundColor)
        
        optionalString = nil
        XCTAssertEqual(.gray, optionalString.generatedForegroundColor)
    }
    
}
