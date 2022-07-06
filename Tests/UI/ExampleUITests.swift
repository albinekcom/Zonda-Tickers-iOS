import XCTest

final class ExampleUITests: XCTestCase {
    
    private var application: XCUIApplication!
    
    // MARK: - Setting
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        application = XCUIApplication()
        application.launch()
    }
    
    // MARK: - Tests
    
    func test_example() {
        XCTAssertTrue(true)
    }
    
}
