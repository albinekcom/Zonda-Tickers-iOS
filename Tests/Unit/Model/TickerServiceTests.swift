import XCTest
@testable import Zonda_Tickers

final class TickerServiceTests: XCTestCase {
    
    private var localDataServicePartialSpy: LocalDataServicePartialSpy!
    private var sut: TickerService!
    
    // MARK: - Setting Up
    
    override func setUp() {
        super.setUp()
        
        localDataServicePartialSpy = .init()
        sut = .init(
            localDataService: localDataServicePartialSpy,
            tickerFetcher: TickerFetcherStub()
        )
    }
    
    // MARK: - Tests
    
    func test_loaded() {
        XCTAssertEqual([.stub1, .stub3], sut.loaded)
    }
    
    func test_fetched() async {
        let fetchedTickers = try? await sut.fetched
        
        XCTAssertEqual([.stub1, .stub2], fetchedTickers)
        XCTAssertTrue(localDataServicePartialSpy.saveTickersInvoked)
    }
    
}
