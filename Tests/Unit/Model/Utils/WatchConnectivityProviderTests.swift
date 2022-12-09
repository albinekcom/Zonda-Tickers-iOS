import WatchConnectivity
import XCTest
@testable import Zonda_Tickers

final class WatchConnectivityProviderTests: XCTestCase {
    
    private var wcSessionPartialSpy: WCSessionPartialSpy!
    private var sut: WatchConnectivityProvider!
    
    // MARK: - Setting Up
    
    override func setUp() {
        super.setUp()
        
        wcSessionPartialSpy = .init()
        sut = .init(session: wcSessionPartialSpy)
    }
    
    // MARK: - Tests
    
    func test_updateUserTickerIds() {
        sut.updateUserTickerIds([])
        
        XCTAssertTrue(sut === wcSessionPartialSpy.delegate)
        XCTAssertTrue(wcSessionPartialSpy.activateInvoked)
        XCTAssertTrue(wcSessionPartialSpy.updateApplicationContextInvoked)
        XCTAssertTrue(wcSessionPartialSpy.transferCurrentComplicationUserInfoInvoked)
    }
    
}

// MARK: - Helpers

private final class WCSessionPartialSpy: WCSessionProtocol {
    
    private(set) var activateInvoked = false
    private(set) var updateApplicationContextInvoked = false
    private(set) var transferCurrentComplicationUserInfoInvoked = false
    
    func activate() {
        activateInvoked = true
    }
    
    func updateApplicationContext(_ applicationContext: [String: Any]) throws {
        updateApplicationContextInvoked = true
    }
    
    func transferCurrentComplicationUserInfo(_ userInfo: [String: Any]) -> WCSessionUserInfoTransfer {
        transferCurrentComplicationUserInfoInvoked = true
        
        return .init()
    }
    
    var delegate: WCSessionDelegate? = nil
    
}
