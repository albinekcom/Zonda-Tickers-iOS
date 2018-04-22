import XCTest

final class TickersViewControllerUITests: XCTestCase {
    
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
    
    func testTappingButtons() {
        sleep(3)
        
        snapshot("01-main")
        
        let tickersNavigationBar = application.navigationBars["Tickers"]
        tickersNavigationBar.buttons["Edit"].tap()
        
        let tablesQuery = application.tables
        tablesQuery.cells.containing(.staticText, identifier:"LTC/PLN").buttons["Delete Ticker Last Value"].tap()
        
        snapshot("02-edit")
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["LTC/PLN"]/*[[".cells.matching(identifier: \"Ticker Last Value\").staticTexts[\"LTC\/PLN\"]",".cells.matching(identifier: \"tickerCell\").staticTexts[\"LTC\/PLN\"]",".staticTexts[\"LTC\/PLN\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tickersNavigationBar.buttons["Done"].tap()
        tickersNavigationBar.buttons["Add"].tap()
        
        application.navigationBars["Add Ticker"].buttons["Cancel"].tap()
        
        XCTAssertGreaterThanOrEqual(application.tables.cells.count, 1)
    }
    
}
