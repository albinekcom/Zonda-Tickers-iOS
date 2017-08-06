import XCTest
@testable import BitBay_Ticker

final class AnalyticsParametersFactoryTests: XCTestCase {
    
    func testMakeParametersFromTicker() {
        let ticker = Ticker(name: .btcpln, jsonDictionary: nil)!
        
        let parameters = AnalyticsParametersFactory.makeParameters(from: ticker)
        
        XCTAssertEqual(["Ticker": "BTC/PLN"], parameters)
    }
    
    func testMakeParametersFromTickers() {
        let tickers = [Ticker(name: .btcpln, jsonDictionary: nil)!, Ticker(name: .etheur, jsonDictionary: nil)!]
        
        let parameters = AnalyticsParametersFactory.makeParameters(from: tickers)
        
        XCTAssertEqual(["Tickers": ["BTC/PLN", "ETH/EUR"]] as NSObject, parameters as NSObject)
    }
    
}
