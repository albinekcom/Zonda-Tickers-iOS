import XCTest
@testable import Zonda_Tickers

final class AutomaticMethodInvokerTests: XCTestCase {
    
    func test_start() {
        let automaticMethodInvokerFireCounter = AutomaticMethodInvokerFireCounter()
        
        let automaticMethodInvoker = AutomaticMethodInvoker(interval: 0.0001)
        automaticMethodInvoker.invokeMethod = { automaticMethodInvokerFireCounter.incrementCount() }
        
        automaticMethodInvoker.start()
        
        let expectation = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertGreaterThan(automaticMethodInvokerFireCounter.count, 2)
    }

}

// MARK: - Helpers

private final class AutomaticMethodInvokerFireCounter {
    
    private(set) var count = 0
    
    func incrementCount() {
        count += 1
    }
    
}
