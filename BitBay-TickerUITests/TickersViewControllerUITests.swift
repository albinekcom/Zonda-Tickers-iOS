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
        
        let bitbayTickerTickersviewNavigationBar = application.navigationBars["BitBay_Ticker.TickersView"]
        bitbayTickerTickersviewNavigationBar.buttons["Edit"].tap()
        bitbayTickerTickersviewNavigationBar.buttons["Done"].tap()
        bitbayTickerTickersviewNavigationBar.buttons["Add"].tap()
        
        // TODO: Put some assertions here
    }
    
}
