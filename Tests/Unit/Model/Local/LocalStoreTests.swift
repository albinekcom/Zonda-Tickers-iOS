import XCTest
@testable import Zonda_Tickers

final class LocalStoreTests: XCTestCase {
    
    func test_saveAndLoad_userTickerIds() {
        let expectedUserTickerIds = ["btc-pln", "eth-pln", "lsk-usd", "ltc-pln"]
        
        LocalStore().save(expectedUserTickerIds, in: .userTickerIds)
        
        XCTAssertEqual(expectedUserTickerIds, LocalStore().load(from: .userTickerIds))
    }
    
    func test_saveAndLoad_tickers() {
        let expectedTickers = [Ticker.stub, Ticker.stub2]
        
        LocalStore().save(expectedTickers, in: .tickers)
        
        XCTAssertEqual(expectedTickers, LocalStore().load(from: .tickers))
    }
    
}
