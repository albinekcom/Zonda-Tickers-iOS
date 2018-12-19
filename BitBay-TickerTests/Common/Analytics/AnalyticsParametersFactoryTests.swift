import XCTest
@testable import BitBay_Ticker

final class AnalyticsParametersFactoryTests: XCTestCase {
    
    func testMakeParametersFromTicker() {
        let ticker = Ticker(name: .btcpln, jsonDictionary: nil)!
        
        let parameters = AnalyticsParametersFactory.makeParameters(from: ticker)
        
        XCTAssertEqual(["Ticker": "BTC/PLN"], parameters)
    }
    
    func testMakeParametersFromRefreshingType() {
        XCTAssertEqual(["Refreshing_Type": "Automatic"], AnalyticsParametersFactory.makeParameters(from: .automatic))
        XCTAssertEqual(["Refreshing_Type": "User"], AnalyticsParametersFactory.makeParameters(from: .user))
        XCTAssertEqual(["Refreshing_Type": "Widget"], AnalyticsParametersFactory.makeParameters(from: .widget))
    }
    
}
