import XCTest
@testable import Zonda_Tickers

final class UserTickersIdServiceTests: XCTestCase {
    
    private var localDataServicePartialSpy: LocalDataServicePartialSpy!
    private var sut: UserTickersIdService!
    
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
        sut.save(userTickersId: ["eth-pln"])
        
        XCTAssertTrue(localDataServicePartialSpy.saveUserTickersIdInvoked)
    }
    
}
