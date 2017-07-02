import XCTest
@testable import BitBay_Ticker

final class SectionOfTickerViewModelTests: XCTestCase {
    
    // MARK: - Tests
    
    func testInitWithOriginal() {
        let ticker = Ticker(name: .btcpln, jsonDictionary: nil)
        let tickerViewModel = TickerViewModel(model: ticker)
        
        let sectionOfTickerViewModel = SectionOfTickerViewModel(items: [tickerViewModel])
        let sectionOfTickerViewModel2 = SectionOfTickerViewModel(original: sectionOfTickerViewModel, items: [tickerViewModel])
        
        XCTAssertEqual(1, sectionOfTickerViewModel2.items.count)
    }
    
}
