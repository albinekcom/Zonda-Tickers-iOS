import XCTest
@testable import Zonda_Tickers

final class AnalyticsServiceTests: XCTestCase {
    
    private var sut: AnalyticsService!
    private var loggerSpy: AnalyticsServiceLoggerSpy!
    
    // MARK: - Setting Up
    
    override func setUp() {
        super.setUp()
        
        loggerSpy = .init()
        sut = .init(logger: loggerSpy)
    }
    
    // MARK: - Tests
    
    func test_trackView() {
        sut.trackView()
        sut.trackView(tickerId: "1")
        
        XCTAssertEqual([nil, [.ticker: "1"]], loggerSpy.loggedViews)
    }
    
    func test_trackUserTickerAppended() {
        sut.trackUserTickerAppended(tickerId: "1")
        
        loggerSpy.assert(expectedLoggedEvents: [(.userTickerAppended, [.ticker: "1"])])
    }

    func test_trackUserTickerDeleted() {
        sut.trackUserTickerDeleted(tickerId: "1")
        
        loggerSpy.assert(expectedLoggedEvents: [(.userTickerDeleted, [.ticker: "1"])])
    }
    
    func test_trackUserTickersRefreshed() {
        sut.trackUserTickersRefreshed(tickerIds: ["1", "2", "3", "4"])
        
        loggerSpy.assert(expectedLoggedEvents: [(.userTickersRefreshed, [.tickers: "1,2,3,4"])])
    }
    
    func test_trackUserTickersRefreshingFailed() {
        sut.trackUserTickersRefreshingFailed(tickerIds: ["1", "2", "3", "4"])
        
        loggerSpy.assert(expectedLoggedEvents: [(.userTickersRefreshingFailed, [.tickers: "1,2,3,4"])])
    }
    
    func test_trackReviewRequested() {
        sut.trackReviewRequested()
        
        loggerSpy.assert(expectedLoggedEvents: [(.reviewRequested, nil)])
    }
    
}
