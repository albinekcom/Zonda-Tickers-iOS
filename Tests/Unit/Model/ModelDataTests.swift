import XCTest
@testable import Zonda_Tickers

final class ModelDataTests: XCTestCase {
    
    private var sut: ModelData!
    
    private var analyticsServiceLoggerSpy: AnalyticsServiceLoggerSpy!
    private var widgetReloadableSpy: WidgetReloadableSpy!
    private var connectivityProviderPartialSpy: ConnectivityProviderPartialSpy!
    
    private var localDataServicePartialSpy: LocalDataServicePartialSpy!
    private var tickerFetcherStub: TickerFetcherStub!
    
    // MARK: - Setting Up
    
    override func setUp() {
        super.setUp()
        
        analyticsServiceLoggerSpy = .init()
        widgetReloadableSpy = .init()
        connectivityProviderPartialSpy = .init()
        
        localDataServicePartialSpy = .init()
        tickerFetcherStub = .init()
        
        sut = .init(
            userTickerIdService: .init(localDataService: localDataServicePartialSpy),
            tickerService: .init(
                localDataService: localDataServicePartialSpy,
                tickerFetcher: tickerFetcherStub
            ),
            widgetReloadable: widgetReloadableSpy,
            connectivityProvider: connectivityProviderPartialSpy
        )
        sut.analyticsService = .init(logger: analyticsServiceLoggerSpy)
    }
    
    // MARK: - Tests
    
    func test_availableTickers() {
        XCTAssertEqual([.stub3], sut.availableTickers())
        XCTAssertEqual([.stub3], sut.availableTickers(searchText: "Lisk"))
        XCTAssertEqual([.stub3], sut.availableTickers(searchText: " Lisk "))
        XCTAssertEqual([.stub3], sut.availableTickers(searchText: "lsk"))
        XCTAssertEqual([.stub3], sut.availableTickers(searchText: "lisk euro"))
        XCTAssertEqual([.stub3], sut.availableTickers(searchText: "euro lisk"))
        XCTAssertEqual([], sut.availableTickers(searchText: "xxx-zzz"))
    }
    
    func test_userTickers() {
        XCTAssertEqual([.stub1, .init(id: "xxx-zzz")!], sut.userTickers)
    }
    
    func test_ticker() {
        XCTAssertEqual(.stub1, sut.ticker(id: "btc-pln"))
        XCTAssertNil(sut.ticker(id: "unknown-ticker"))
    }
    
    func test_appendUserTickerId() {
        sut.appendUserTickerId("appended-newtickerid")
        
        XCTAssertEqual([.stub1, .init(id: "xxx-zzz")!, .init(id: "appended-newtickerid")!], sut.userTickers)
        XCTAssertTrue(localDataServicePartialSpy.saveUserTickerIdsInvoked)
        XCTAssertTrue(widgetReloadableSpy.reloadAllTimelinesInvoked)
        XCTAssertTrue(connectivityProviderPartialSpy.updateInvoked)
        analyticsServiceLoggerSpy.assert(expectedLoggedEvents: [(.userTickerAppended, [.ticker: "appended-newtickerid"])])
    }
    
    func test_removeUserTicker() {
        sut.removeUserTicker(at: .init(integer: 1))
        XCTAssertEqual([.stub1], sut.userTickers)
        
        sut.removeUserTicker(at: .init(integer: 0))
        XCTAssertEqual([], sut.userTickers)
        
        XCTAssertTrue(localDataServicePartialSpy.saveUserTickerIdsInvoked)
        XCTAssertTrue(widgetReloadableSpy.reloadAllTimelinesInvoked)
        XCTAssertTrue(connectivityProviderPartialSpy.updateInvoked)
        analyticsServiceLoggerSpy.assert(expectedLoggedEvents: [
            (.userTickerDeleted, [.ticker: "xxx-zzz"]),
            (.userTickerDeleted, [.ticker: "btc-pln"])
        ])
    }
    
    func test_moveUserTicker() {
        sut.moveUserTicker(from: .init(integer: 1), to: 0)
        
        XCTAssertEqual([.init(id: "xxx-zzz")!, .stub1], sut.userTickers)
        
        XCTAssertTrue(localDataServicePartialSpy.saveUserTickerIdsInvoked)
        XCTAssertTrue(widgetReloadableSpy.reloadAllTimelinesInvoked)
        XCTAssertTrue(connectivityProviderPartialSpy.updateInvoked)
    }
    
    func test_refreshTickers_success() async {
        await sut.refreshTickers()

        XCTAssertEqual([.stub2], sut.availableTickers())
        XCTAssertEqual([.stub1, .init(id: "xxx-zzz")!], sut.userTickers)
        XCTAssertEqual(.refreshingSuccess, sut.state)
        XCTAssertTrue(localDataServicePartialSpy.saveTickersInvoked)
        XCTAssertTrue(widgetReloadableSpy.reloadAllTimelinesInvoked)
        analyticsServiceLoggerSpy.assert(expectedLoggedEvents: [(.userTickersRefreshed, [.tickers: "btc-pln,xxx-zzz"])])
    }
    
    func test_refreshTickers_failure() async {
        tickerFetcherStub.variant = .error
        
        await sut.refreshTickers()
        
        XCTAssertEqual([.stub3], sut.availableTickers())
        XCTAssertEqual([.stub1, .init(id: "xxx-zzz")!], sut.userTickers)
        XCTAssertEqual(.refreshingFailure(error: TickerFetcherStub.CustomError.fetch), sut.state)
        XCTAssertFalse(localDataServicePartialSpy.saveTickersInvoked)
        XCTAssertTrue(widgetReloadableSpy.reloadAllTimelinesInvoked)
        analyticsServiceLoggerSpy.assert(expectedLoggedEvents: [(.userTickersRefreshingFailed, [.tickers: "btc-pln,xxx-zzz"])])
    }
    
    func test_reloadTickers() {
        localDataServicePartialSpy.loadTickersStub = []
        sut.reloadTickers()
        XCTAssertEqual([], sut.availableTickers())
        
        localDataServicePartialSpy.loadTickersStub = [.stub2, .stub3]
        sut.reloadTickers()
        XCTAssertEqual([.stub2, .stub3], sut.availableTickers())
    }
    
}

// MARK: - Helpers

private final class WidgetReloadableSpy: WidgetReloadable {
    
    private(set) var reloadAllTimelinesInvoked = false
    
    func reloadAllTimelines() {
        reloadAllTimelinesInvoked = true
    }
    
}

private final class ConnectivityProviderPartialSpy: ConnectivityProvider {
    
    private(set) var updateInvoked = false
    
    var delegate: ConnectivityProviderDelegate? = nil
    
    func update(tickers: [Ticker], userTickerIds: [String]) {
        updateInvoked = true
    }
    
}
