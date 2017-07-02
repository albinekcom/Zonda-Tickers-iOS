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
        
        let cells = application.tables.cells
        cells.element(boundBy: 0).tap()
        
        // TODO: Put some assertions here
    }
    
}
