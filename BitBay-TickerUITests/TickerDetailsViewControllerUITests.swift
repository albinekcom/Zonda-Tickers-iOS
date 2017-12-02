import XCTest

final class TickerDetailsViewControllerUITests: XCTestCase {
    
    // MARK: - Setting
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        XCUIApplication().launch()
    }
    
    // MARK: - Tests
    
    func testGoingToDetails() {
        let application = XCUIApplication()
        
        application.tables.cells.containing(.staticText, identifier:"LTC/PLN").element.doubleTap()
        
        application.navigationBars["LTC/PLN"].buttons["Tickers"].tap()
        
        XCTAssertGreaterThanOrEqual(application.tables.cells.count, 1)
    }
    
}
