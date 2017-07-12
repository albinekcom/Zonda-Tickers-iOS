import XCTest
@testable import BitBay_Ticker

final class TickerViewModelTests: XCTestCase {
    
    let tickerJSONDictionary = [
        "max": 1.1,
        "min": 2.2,
        "last": 3.3,
        "bid": 4.4,
        "ask": 5.5,
        "vwap": 6.6,
        "average": 7.7,
        "volume": 8.8
    ]
    
    var viewModelWithEmptyTicker: TickerViewModel!
    var viewModel: TickerViewModel!
    
    // MARK: - Setting
    
    override func setUp() {
        super.setUp()
        
        let emptyTicker = Ticker(name: .btcpln, jsonDictionary: [:])
        viewModelWithEmptyTicker = TickerViewModel(ticker: emptyTicker)
        
        let ticker = Ticker(name: .btcpln, jsonDictionary: tickerJSONDictionary)
        viewModel = TickerViewModel(ticker: ticker)
    }
    
    // MARK: - Tests
    
    func testName() {
        XCTAssertEqual("BTC/PLN", viewModel.name)
    }
    
    func testLast() {
        XCTAssertEqual("3.30 PLN", viewModel.last)
        XCTAssertEqual("- PLN", viewModelWithEmptyTicker.last)
    }
    
}
