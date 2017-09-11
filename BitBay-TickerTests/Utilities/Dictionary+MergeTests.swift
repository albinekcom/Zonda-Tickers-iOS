import XCTest
@testable import BitBay_Ticker

final class Dictionary_MergeTests: XCTestCase {
    
    func testMerge() {
        var dictionary1 = ["a": "1"]
        let dictionary2 = ["b": "2"]
        
        dictionary1.merge(with: dictionary2)
        
        XCTAssertEqual(["a": "1", "b": "2"], dictionary1)
    }
    
    func testMerged() {
        let dictionary1 = ["a": "1"]
        let dictionary2 = ["b": "2"]
        
        let mergedDictionaries = dictionary1.merged(with: dictionary2)
        
        XCTAssertEqual(["a": "1", "b": "2"], mergedDictionaries)
    }
    
}
