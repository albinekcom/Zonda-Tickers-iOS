import XCTest

class UITests: XCTestCase {
    
    var application: XCUIApplication!
    
    // MARK: - Setting Up
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        application = XCUIApplication()
        application.launchArguments = launchArguments
        
        application.launch()
    }
    
    var launchArguments: [String] {
        [AppArguments.uiTestsKey]
    }
    
}
