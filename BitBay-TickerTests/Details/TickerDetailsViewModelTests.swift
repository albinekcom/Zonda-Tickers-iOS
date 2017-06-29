import XCTest
@testable import BitBay_Ticker

final class TickerDetailsViewModelTests: XCTestCase {
    
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
    
    var viewModelWithEmptyTicker: TickerDetailsViewModel!
    var viewModel: TickerDetailsViewModel!
    
    // MARK: - Setting
    
    override func setUp() {
        super.setUp()
        
        let emptyTicker = Ticker(name: .btcpln, jsonDictionary: [:])
        viewModelWithEmptyTicker = TickerDetailsViewModel(model: emptyTicker)
        
        let ticker = Ticker(name: .btcpln, jsonDictionary: tickerJSONDictionary)
        viewModel = TickerDetailsViewModel(model: ticker)
    }
    
    // MARK: - Tests
    
    func testName() {
        XCTAssertEqual("BTC/PLN", viewModel.name)
    }
    
    func testValuesForEmptyTicker() {
        XCTAssertEqual(8, viewModelWithEmptyTicker.values.count)
        
        XCTAssertEqual("Last", viewModelWithEmptyTicker.values[0].title)
        XCTAssertEqual("- PLN", viewModelWithEmptyTicker.values[0].value)
        XCTAssertEqual("Max", viewModelWithEmptyTicker.values[1].title)
        XCTAssertEqual("- PLN", viewModelWithEmptyTicker.values[1].value)
        XCTAssertEqual("Min", viewModelWithEmptyTicker.values[2].title)
        XCTAssertEqual("- PLN", viewModelWithEmptyTicker.values[2].value)
        XCTAssertEqual("Bid", viewModelWithEmptyTicker.values[3].title)
        XCTAssertEqual("- PLN", viewModelWithEmptyTicker.values[3].value)
        XCTAssertEqual("Ask", viewModelWithEmptyTicker.values[4].title)
        XCTAssertEqual("- PLN", viewModelWithEmptyTicker.values[4].value)
        XCTAssertEqual("Vwap", viewModelWithEmptyTicker.values[5].title)
        XCTAssertEqual("- PLN", viewModelWithEmptyTicker.values[5].value)
        XCTAssertEqual("Average", viewModelWithEmptyTicker.values[6].title)
        XCTAssertEqual("- PLN", viewModelWithEmptyTicker.values[6].value)
        XCTAssertEqual("Volume", viewModelWithEmptyTicker.values[7].title)
        XCTAssertEqual("-", viewModelWithEmptyTicker.values[7].value)
    }
    
    func testValuesForFilledTicker() {
        XCTAssertEqual(8, viewModel.values.count)
        
        XCTAssertEqual("Last", viewModel.values[0].title)
        XCTAssertEqual("3.3 PLN", viewModel.values[0].value)
        XCTAssertEqual("Max", viewModel.values[1].title)
        XCTAssertEqual("1.1 PLN", viewModel.values[1].value)
        XCTAssertEqual("Min", viewModel.values[2].title)
        XCTAssertEqual("2.2 PLN", viewModel.values[2].value)
        XCTAssertEqual("Bid", viewModel.values[3].title)
        XCTAssertEqual("4.4 PLN", viewModel.values[3].value)
        XCTAssertEqual("Ask", viewModel.values[4].title)
        XCTAssertEqual("5.5 PLN", viewModel.values[4].value)
        XCTAssertEqual("Vwap", viewModel.values[5].title)
        XCTAssertEqual("6.6 PLN", viewModel.values[5].value)
        XCTAssertEqual("Average", viewModel.values[6].title)
        XCTAssertEqual("7.7 PLN", viewModel.values[6].value)
        XCTAssertEqual("Volume", viewModel.values[7].title)
        XCTAssertEqual("8.8", viewModel.values[7].value)
    }
    
}
