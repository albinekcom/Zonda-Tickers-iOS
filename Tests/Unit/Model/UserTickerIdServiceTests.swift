import XCTest
@testable import Zonda_Tickers

final class UserTickerIdServiceTests: XCTestCase {
    
    private var localDataServicePartialSpy: LocalDataServicePartialSpy!
    private var sut: UserTickerIdService!
    
    // MARK: - Setting Up
    
    override func setUp() {
        super.setUp()
        
        localDataServicePartialSpy = .init()
        sut = .init(localDataService: localDataServicePartialSpy)
    }
    
    // MARK: - Tests
    
    func test_loaded() {
        XCTAssertEqual(["btc-pln", "xxx-zzz"], sut.loaded)
    }
    
    func test_save() {
        sut.save(userTickerIds: ["eth-pln"])
        
        XCTAssertTrue(localDataServicePartialSpy.saveUserTickerIdsInvoked)
    }
    
}
