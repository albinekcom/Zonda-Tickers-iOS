import XCTest

final class TickersViewControllerUITests: XCTestCase {
    
    // MARK: - Setting
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        XCUIApplication().launch()
    }
    
    // MARK: - Tests
    
    func testTappingButtons() {
        let application = XCUIApplication()
        
        let tickersNavigationBar = application.navigationBars["Tickers"]
        tickersNavigationBar.buttons["Edit"].tap()
        tickersNavigationBar.buttons["Done"].tap()
        tickersNavigationBar.buttons["Add"].tap()
        
        application.navigationBars["Add Ticker"].buttons["Cancel"].tap()
        
        XCTAssertGreaterThanOrEqual(1, application.tables.cells.count)
    }
    
}
