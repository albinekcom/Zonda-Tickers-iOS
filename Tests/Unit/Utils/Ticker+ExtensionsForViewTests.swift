import XCTest
@testable import Zonda_Tickers

final class Ticker_ExtensionsForViewTests: XCTestCase {
    
    func test_firstCurrencyText() {
        XCTAssertEqual("BTC", Ticker.stub().firstCurrencyText)
    }
    
    func test_firstCurrencyName() {
        XCTAssertEqual("-", Ticker.stub().firstCurrencyName)
        XCTAssertEqual("Bitcoin", Ticker.stub(firstCurrency: .init(id: "btc", name: "Bitcoin")).firstCurrencyName)
    }
    
    func test_secondCurrencyText() {
        XCTAssertEqual("PLN", Ticker.stub().secondCurrencyText)
    }
    
    func test_name() {
        XCTAssertEqual("BTC \\ PLN", Ticker.stub().name)
    }
    
    func test_rateText() {
        XCTAssertEqual("-", Ticker.stub().rateText)
        XCTAssertEqual("123.46", Ticker.stub(rate: 123.456).rateText)
        XCTAssertEqual("123.456", Ticker.stub(secondCurrency: .init(id: "pln", precision: 3), rate: 123.456).rateText)
    }
    
    func test_changeImageName() {
        XCTAssertEqual(.squareFill, Ticker.stub().changeImageName)
        XCTAssertEqual(.arrowTriangleUpFill, Ticker.stub(rate: 2, average: 1).changeImageName)
        XCTAssertEqual(.arrowTriangleDownFill, Ticker.stub(rate: 1, average: 2).changeImageName)
        XCTAssertEqual(.squareFill, Ticker.stub(rate: 1, average: 1).changeImageName)
    }
    
    func test_changeColor() {
        XCTAssertEqual(.secondary, Ticker.stub().changeColor)
        XCTAssertEqual(.green, Ticker.stub(rate: 2, average: 1).changeColor)
        XCTAssertEqual(.red, Ticker.stub(rate: 1, average: 2).changeColor)
        XCTAssertEqual(.orange, Ticker.stub(rate: 1, average: 1).changeColor)
    }
    
    func test_changeText() {
        XCTAssertEqual("-", Ticker.stub().changeText)
        XCTAssertEqual("+1.00", Ticker.stub(rate: 2, average: 1).changeText)
        XCTAssertEqual("-1.00", Ticker.stub(rate: 1, average: 2).changeText)
        XCTAssertEqual("0.00", Ticker.stub(rate: 1, average: 1).changeText)
    }
    
    func test_percentageChangeWithPositiveSignText() {
        XCTAssertEqual("-", Ticker.stub().percentageChangeWithPositiveSignText)
        XCTAssertEqual("+100.00%", Ticker.stub(rate: 2, average: 1).percentageChangeWithPositiveSignText)
        XCTAssertEqual("-50.00%", Ticker.stub(rate: 1, average: 2).percentageChangeWithPositiveSignText)
        XCTAssertEqual("0.00%", Ticker.stub(rate: 1, average: 1).percentageChangeWithPositiveSignText)
    }
    
    func test_percentageChangeWithoutSignText() {
        XCTAssertEqual("-", Ticker.stub().percentageChangeWithoutSignText)
        XCTAssertEqual("100.00%", Ticker.stub(rate: 2, average: 1).percentageChangeWithoutSignText)
        XCTAssertEqual("50.00%", Ticker.stub(rate: 1, average: 2).percentageChangeWithoutSignText)
        XCTAssertEqual("0.00%", Ticker.stub(rate: 1, average: 1).percentageChangeWithoutSignText)
    }
    
    func test_previousRateText() {
        XCTAssertEqual("-", Ticker.stub().previousRateText)
        XCTAssertEqual("1.00", Ticker.stub(previousRate: 1).previousRateText)
    }
    
    func test_highestRateText() {
        XCTAssertEqual("-", Ticker.stub().highestRateText)
        XCTAssertEqual("1.00", Ticker.stub(highestRate: 1).highestRateText)
    }
    
    func test_lowestRateText() {
        XCTAssertEqual("-", Ticker.stub().lowestRateText)
        XCTAssertEqual("1.00", Ticker.stub(lowestRate: 1).lowestRateText)
    }
    
    func test_highestBidText() {
        XCTAssertEqual("-", Ticker.stub().highestBidText)
        XCTAssertEqual("1.00", Ticker.stub(highestBid: 1).highestBidText)
    }
    
    func test_lowestAskText() {
        XCTAssertEqual("-", Ticker.stub().lowestAskText)
        XCTAssertEqual("1.00", Ticker.stub(lowestAsk: 1).lowestAskText)
    }
    
    func test_averageText() {
        XCTAssertEqual("-", Ticker.stub().averageText)
        XCTAssertEqual("1.00", Ticker.stub(average: 1).averageText)
    }
    
    func test_volumeText() {
        XCTAssertEqual("-", Ticker.stub().volumeText)
        XCTAssertEqual("1", Ticker.stub(volume: 1).volumeText)
    }
    
    func test_volumeValueText() {
        XCTAssertEqual("-", Ticker.stub().volumeValueText)
        XCTAssertEqual("25.00", Ticker.stub(rate: 5, volume: 5).volumeValueText)
    }
    
    func test_name_for_optional_ticker() {
        let optionalNilTicker: Ticker? = nil
        XCTAssertEqual("- \\ -", optionalNilTicker.name)
        
        let optionalTicker: Ticker? = .stub(rate: 1, average: 2)
        XCTAssertEqual("BTC \\ PLN", optionalTicker.name)
    }
    
    func test_standardRowModel() {
        XCTAssertEqual(.init(
            firstCurrencyId: "btc",
            firstCurrencyText: "BTC",
            secondCurrencyText: "PLN",
            rateText: "2.00",
            percentageChangeWithoutSignText: "100.00%",
            percentageChangeWithPositiveSignText: "+100.00%",
            changeImageName: .arrowTriangleUpFill,
            changeColor: .green
        ), Ticker.stub(rate: 2, average: 1).standardRowModel)
    }
    
}

private extension Ticker {
    
    static func stub(
        firstCurrency: Currency = .init(id: "btc"),
        secondCurrency: Currency = .init(id: "pln"),
        highestBid: Double? = nil,
        lowestAsk: Double? = nil,
        rate: Double? = nil,
        previousRate: Double? = nil,
        highestRate: Double? = nil,
        lowestRate: Double? = nil,
        volume: Double? = nil,
        average: Double? = nil
    ) -> Ticker {
        .init(
            firstCurrency: firstCurrency,
            secondCurrency: secondCurrency,
            highestBid: highestBid,
            lowestAsk: lowestAsk,
            rate: rate,
            previousRate: previousRate,
            highestRate: highestRate,
            lowestRate: lowestRate,
            volume: volume,
            average: average
        )
    }
    
}
