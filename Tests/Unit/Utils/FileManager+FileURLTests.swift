import XCTest
@testable import Zonda_Tickers

final class FileManager_FileURLTests: XCTestCase {
    
    func test_fileURL() {
        assert(contains: "/tickers.json", fileName: .tickers)
        assert(contains: "/user_ticker_ids.json", fileName: .userTickerIds)
    }
    
    private func assert(
        contains: String,
        fileName: FileManagerDataService.FileName
    ) {
        let path = FileManager().fileURL(for: fileName)!.path
        
        XCTAssertTrue(path.contains(contains))
        XCTAssertTrue(path.contains("/Containers/Shared/AppGroup/"))
    }
    
}
