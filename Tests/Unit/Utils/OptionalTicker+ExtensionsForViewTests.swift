import XCTest
@testable import Zonda_Tickers

final class OptionalTicker_ExtensionsForViewTests: XCTestCase {
    
    func test_change() {
        var optionalTicker: Ticker? = nil
        XCTAssertEqual(0, optionalTicker.change)
        
        optionalTicker = Ticker.stub(rate: 2, average: 1)
        XCTAssertEqual(1, optionalTicker.change)
    }
    
    func test_changeColor() {
        var optionalTicker: Ticker? = nil
        XCTAssertEqual(.secondary, optionalTicker.changeColor)
        
        optionalTicker = Ticker.stub()
        XCTAssertEqual(.secondary, optionalTicker.changeColor)
        
        optionalTicker = Ticker.stub(rate: 2, average: 1)
        XCTAssertEqual(.green, optionalTicker.changeColor)
        
        optionalTicker = Ticker.stub(rate: 1, average: 2)
        XCTAssertEqual(.red, optionalTicker.changeColor)
        
        optionalTicker = Ticker.stub(rate: 1, average: 1)
        XCTAssertEqual(.orange, optionalTicker.changeColor)
    }
    
    func test_changeImageName() {
        var optionalTicker: Ticker? = nil
        XCTAssertEqual(.squareFill, optionalTicker.changeImageName)
        
        optionalTicker = Ticker.stub()
        XCTAssertEqual(.squareFill, optionalTicker.changeImageName)
        
        optionalTicker = Ticker.stub(rate: 2, average: 1)
        XCTAssertEqual(.arrowTriangleUpFill, optionalTicker.changeImageName)
        
        optionalTicker = Ticker.stub(rate: 1, average: 2)
        XCTAssertEqual(.arrowTriangleUpFill, optionalTicker.changeImageName)
        
        optionalTicker = Ticker.stub(rate: 1, average: 1)
        XCTAssertEqual(.squareFill, optionalTicker.changeImageName)
    }
    
    func test_firstCurrencyText() {
        var optionalTicker: Ticker? = nil
        XCTAssertEqual("-", optionalTicker.firstCurrencyText)
        
        optionalTicker = Ticker.stub()
        XCTAssertEqual("BTC", optionalTicker.firstCurrencyText)
    }
    
    func test_percentageChangeWithoutSignText() {
        var optionalTicker: Ticker? = nil
        XCTAssertEqual("-", optionalTicker.percentageChangeWithoutSignText)
        
        optionalTicker = Ticker.stub()
        XCTAssertEqual("-", optionalTicker.percentageChangeWithoutSignText)
        
        optionalTicker = Ticker.stub(rate: 2, average: 1)
        XCTAssertEqual("100.00%", optionalTicker.percentageChangeWithoutSignText)
        
        optionalTicker = Ticker.stub(rate: 1, average: 2)
        XCTAssertEqual("50.00%", optionalTicker.percentageChangeWithoutSignText)
        
        optionalTicker = Ticker.stub(rate: 1, average: 1)
        XCTAssertEqual("0.00%", optionalTicker.percentageChangeWithoutSignText)
    }
    
    func test_percentageChangeWithPositiveSignText() {
        var optionalTicker: Ticker? = nil
        XCTAssertEqual("-", optionalTicker.percentageChangeWithPositiveSignText)
        
        optionalTicker = Ticker.stub()
        XCTAssertEqual("-", optionalTicker.percentageChangeWithPositiveSignText)
        
        optionalTicker = Ticker.stub(rate: 2, average: 1)
        XCTAssertEqual("+100.00%", optionalTicker.percentageChangeWithPositiveSignText)
        
        optionalTicker = Ticker.stub(rate: 1, average: 2)
        XCTAssertEqual("-50.00%", optionalTicker.percentageChangeWithPositiveSignText)
        
        optionalTicker = Ticker.stub(rate: 1, average: 1)
        XCTAssertEqual("0.00%", optionalTicker.percentageChangeWithPositiveSignText)
    }
    
    func test_rateText() {
        var optionalTicker: Ticker? = nil
        XCTAssertEqual("-", optionalTicker.rateText)
        
        optionalTicker = Ticker.stub()
        XCTAssertEqual("-", optionalTicker.rateText)
        
        optionalTicker = Ticker.stub(rate: 123.456)
        XCTAssertEqual("123.46", optionalTicker.rateText)
        
        optionalTicker = Ticker.stub(secondCurrency: .init(id: "pln", precision: 3), rate: 123.456)
        XCTAssertEqual("123.456", optionalTicker.rateText)
    }
    
    func test_secondCurrencyText() {
        var optionalTicker: Ticker? = nil
        XCTAssertEqual("-", optionalTicker.secondCurrencyText)
        
        optionalTicker = Ticker.stub()
        XCTAssertEqual("PLN", optionalTicker?.secondCurrencyText)
    }
    
    func test_shortTitle() {
        var optionalTicker: Ticker? = nil
        XCTAssertEqual("-\\-", optionalTicker.shortTitle)
        
        optionalTicker = Ticker.stub()
        XCTAssertEqual("BTC\\PLN", optionalTicker.shortTitle)
    }
    
    func test_title() {
        var optionalTicker: Ticker? = nil
        XCTAssertEqual("- \\ -", optionalTicker.title)
        
        optionalTicker = Ticker.stub()
        XCTAssertEqual("BTC \\ PLN", optionalTicker.title)
    }
    
}
