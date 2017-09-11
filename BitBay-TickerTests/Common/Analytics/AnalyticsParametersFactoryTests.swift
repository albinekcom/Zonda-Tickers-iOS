import XCTest
@testable import BitBay_Ticker

final class AnalyticsParametersFactoryTests: XCTestCase {
    
    func testMakeParametersFromTicker() {
        let ticker = Ticker(name: .btcpln, jsonDictionary: nil)!
        
        let parameters = AnalyticsParametersFactory.makeParameters(from: ticker)
        
        XCTAssertEqual(["Ticker": "BTC/PLN"], parameters)
    }
    
    func testMakeParametersFromTickers() {
        let tickers = [Ticker(name: .btcpln, jsonDictionary: nil)!, Ticker(name: .etheur, jsonDictionary: nil)!, Ticker(name: .btcusd, jsonDictionary: nil)!]
        
        let parameters = AnalyticsParametersFactory.makeParameters(from: tickers)
        
        XCTAssertEqual(["Tickers": "BTC/PLN|ETH/EUR|BTC/USD"], parameters)
    }
    
    func testMakeParametersFromRefreshingType() {
        XCTAssertEqual(["Refreshing Type": "Automatic"], AnalyticsParametersFactory.makeParameters(from: .automatic))
        XCTAssertEqual(["Refreshing Type": "User"], AnalyticsParametersFactory.makeParameters(from: .user))
        XCTAssertEqual(["Refreshing Type": "Widget"], AnalyticsParametersFactory.makeParameters(from: .widget))
    }
    
}
