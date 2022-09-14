import XCTest
@testable import Zonda_Tickers

final class ModelDataStateTests: XCTestCase {
    
    func test_equatable() {
        assertEqual(
            lhs: .initializing,
            rhs: .initializing
        )
        
        assertEqual(
            lhs: .refreshing,
            rhs: .refreshing
        )
        
        assertEqual(
            lhs: .refreshingSuccess,
            rhs: .refreshingSuccess
        )
        
        assertEqual(
            lhs: .refreshingFailure(error: TickerFetcherStub.CustomError.fetch),
            rhs: .refreshingFailure(error: TickerFetcherStub.CustomError.fetch)
        )
        
        assertNotEqual(
            lhs: .initializing,
            rhs: .refreshing
        )
    }
    
    private func assertEqual(
        lhs: ModelData.State,
        rhs: ModelData.State
    ) {
        XCTAssertEqual(lhs, rhs)
    }
    
    private func assertNotEqual(
        lhs: ModelData.State,
        rhs: ModelData.State
    ) {
        XCTAssertNotEqual(lhs, rhs)
    }
    
}
