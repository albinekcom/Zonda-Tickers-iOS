import XCTest
@testable import Zonda_Tickers

final class String_FirstCharacterTests: XCTestCase {
    
    func test_firstCharacter() {
        var optionalString: String?
        
        optionalString = "btc"
        XCTAssertEqual("b", optionalString.firstCharacter)
        
        optionalString = ""
        XCTAssertEqual("-", optionalString.firstCharacter)
        
        optionalString = nil
        XCTAssertEqual("-", optionalString.firstCharacter)
    }
    
}
