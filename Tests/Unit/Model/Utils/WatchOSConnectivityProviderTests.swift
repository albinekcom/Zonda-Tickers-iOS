import WatchConnectivity
import XCTest
@testable import Zonda_Tickers

final class WatchOSConnectivityProviderTests: XCTestCase {
    
    private var wcSessionPartialSpy: WCSessionPartialSpy!
    private var sut: WatchOSConnectivityProvider!
    
    // MARK: - Setting Up
    
    override func setUp() {
        super.setUp()
        
        wcSessionPartialSpy = .init()
        sut = .init(session: wcSessionPartialSpy)
    }
    
    // MARK: - Tests
    
    func test_send() {
        sut.send(userTickerIds: [])
        
        XCTAssertTrue(sut === wcSessionPartialSpy.delegate)
        XCTAssertTrue(wcSessionPartialSpy.activateInvoked)
        XCTAssertTrue(wcSessionPartialSpy.updateApplicationContextInvoked)
    }
    
}

// MARK: - Helpers

private final class WCSessionPartialSpy: WCSessionProtocol {
    
    private(set) var activateInvoked = false
    private(set) var updateApplicationContextInvoked = false
    
    func activate() {
        activateInvoked = true
    }
    
    func updateApplicationContext(_ applicationContext: [String: Any]) throws {
        updateApplicationContextInvoked = true
    }
    
    var delegate: WCSessionDelegate? = nil
    
}
