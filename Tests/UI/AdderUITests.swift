import XCTest

final class AdderUITests: UITests {
    
    override func setUp() {
        super.setUp()
        
        XCTAssertEqual(2, application.cells.count)
        
        application.buttons["Add Ticker"].tap()
    }
    
    // MARK: - Tests
    
    func test_searching() {
        searchField.tap()
        searchField.typeText("EthX")
        XCTAssertTrue(application.staticTexts["No results"].exists)
        
        application.buttons["Cancel"].tap()
        
        searchField.tap()
        searchField.typeText("Eth")
        XCTAssertFalse(application.staticTexts["No results"].exists)
    }
    
    func test_adding() {
        application.buttons["ETH \\ USD"].tap()
        
        XCTAssertTrue(application.staticTexts["No results"].exists)
        
        application.buttons["X Circle"].tap()
        
        XCTAssertEqual(3, application.cells.count)
    }
    
    func test_adding_from_search() {
        searchField.tap()
        searchField.typeText("Ethereum\n")
        
        application.buttons["ETH \\ USD"].tap()
        application.buttons["Cancel"].tap()
        
        XCTAssertTrue(application.staticTexts["No results"].exists)
        
        application.buttons["X Circle"].tap()
        
        XCTAssertEqual(3, application.cells.count)
    }
    
    private var searchField: XCUIElement {
        application.searchFields.firstMatch
    }
    
}
