import XCTest
@testable import BitBay_Ticker

final class TickerTests: XCTestCase {
    
    func testTitle() {
        let firstCurrency = Currency(currency: "BTC", minimumOffer: 0.0001, scale: 3)
        let secondCurrency = Currency(currency: "PLN", minimumOffer: 0.01, scale: 2)
        let ticker = Ticker(id: "BTC-PLN", firstCurrency: firstCurrency, secondCurrency: secondCurrency, highestBid: 123, lowestAsk: 456, rate: 789, previousRate: 111.11)
        
        XCTAssertEqual(ticker.title, "BTC/PLN")
    }
    
}
