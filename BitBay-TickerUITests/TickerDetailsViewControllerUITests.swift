import XCTest

final class TickerDetailsViewControllerUITests: XCTestCase {
    
    private var application: XCUIApplication!
    
    // MARK: - Setting
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        application = XCUIApplication()
        setupSnapshot(application)
        application.launch()
    }
    
    // MARK: - Tests
    
    func testGoingToDetails() {
        application.tables.cells.containing(.staticText, identifier:"LTC/PLN").element.doubleTap()
        
        snapshot("03-details")
        
        application.navigationBars["LTC/PLN"].buttons["Tickers"].tap()
        
        XCTAssertGreaterThanOrEqual(application.tables.cells.count, 1)
    }
    
}
