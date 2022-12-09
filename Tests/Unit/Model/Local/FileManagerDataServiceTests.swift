import XCTest
@testable import Zonda_Tickers

final class FileManagerDataServiceTests: XCTestCase {
    
    private let fileManagerDataService = FileManagerDataService(saveDispatchQueue: DispatchQueueStub())
    
    func test_saveAndLoad_userTickerIds() {
        let expectedUserTickerIds = ["btc-pln", "eth-pln", "lsk-usd", "ltc-pln"]
        
        fileManagerDataService.save(userTickerIds: expectedUserTickerIds)
        
        XCTAssertEqual(expectedUserTickerIds, fileManagerDataService.loadUserTickerIds())
    }
    
    func test_saveAndLoad_tickers() {
        let expectedTickers: [Ticker] = [.stub1, .stub2]
        
        fileManagerDataService.save(tickers: expectedTickers)
        
        XCTAssertEqual(expectedTickers, fileManagerDataService.loadTickers())
    }
    
    func test_saveAndLoad_userTickerIds_for_nil_fileURL() {
        let expectedUserTickerIds = ["btc-pln", "eth-pln", "lsk-usd", "ltc-pln"]
        
        let fileManagerDataService = FileManagerDataService(
            sharedContainer: SharedContainerStub(),
            saveDispatchQueue: DispatchQueueStub()
        )
        
        fileManagerDataService.save(userTickerIds: expectedUserTickerIds)
        
        XCTAssertEqual([], fileManagerDataService.loadUserTickerIds())
    }
    
    func test_saveAndLoad_tickers_for_nil_fileURL() {
        let expectedTickers: [Ticker] = [.stub1, .stub2]
        
        let fileManagerDataService = FileManagerDataService(
            sharedContainer: SharedContainerStub(),
            saveDispatchQueue: DispatchQueueStub()
        )
        
        fileManagerDataService.save(tickers: expectedTickers)
        
        XCTAssertEqual([], fileManagerDataService.loadTickers())
    }
    
}

// MARK: - Helpers

private final class DispatchQueueStub: Dispatching {
    
    func async(execute work: @escaping @convention(block) () -> Void) {
        work()
    }
    
}

private final class SharedContainerStub: SharedContainer {
    
    func fileURL(for fileName: FileManagerDataService.FileName) -> URL? { nil }
    
}
