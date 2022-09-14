import XCTest

final class ListUITests: UITests {
    
    func test_removing_tickers() {
        application.cells.buttons["BTC \\ PLN"].swipeLeft()
        application.buttons["Delete"].tap()
        application.buttons["Edit Tickers"].tap()
        application.images["remove"].tap()
        application.buttons["Delete"].tap()
        
        XCTAssertEqual("Tickers", application.navigationBars.firstMatch.identifier)
        XCTAssertEqual(0, application.cells.count)
        XCTAssertTrue(application.staticTexts["Press + to add a Ticker"].exists)
    }
    
    func test_rearranging_tickers() {
        XCTAssertEqual("BTC \\ PLN", application.cells.buttons.firstMatch.label)
        
        application.buttons["Edit Tickers"].tap()
        application.cells.buttons["XXX \\ ZZZ"].press(
            forDuration: 0.5,
            thenDragTo: application.cells.buttons["BTC \\ PLN"],
            withVelocity: .default,
            thenHoldForDuration: 0.5
        )
        application.buttons["Edit Tickers"].tap()
        
        XCTAssertEqual("XXX \\ ZZZ", application.cells.buttons.firstMatch.label)
    }
    
}
