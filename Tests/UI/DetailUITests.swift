import XCTest

final class DetailUITests: UITests {
    
    func test_ticker() {
        let tickerLabel = "BTC \\ PLN"
        
        application.cells.buttons[tickerLabel].tap()
        
        XCTAssertEqual(tickerLabel, application.navigationBars.firstMatch.identifier)
        
        assertRow(expectedLabel: "Name", expectedValue: "Bitcoin")
        assertRow(expectedLabel: "Rate", expectedValue: "3.00")
        assertRow(expectedLabel: "Change", expectedValue: "-5.00")
        assertRow(expectedLabel: "Change (%)", expectedValue:  "-62.50%")
        assertRow(expectedLabel: "Previous rate", expectedValue: "4.00")
        assertRow(expectedLabel: "Highest rate", expectedValue: "5.00")
        assertRow(expectedLabel: "Lowest rate", expectedValue: "6.00")
        
        application.swipeUp()
        
        assertRow(expectedLabel: "Bid", expectedValue: "1.00")
        assertRow(expectedLabel: "Ask", expectedValue: "2.00")
        assertRow(expectedLabel: "Average", expectedValue: "8.00")
        assertRow(expectedLabel: "Volume", expectedValue: "7")
        assertRow(expectedLabel: "Volume value", expectedValue: "21.00")
    }
    
    func test_unsupported_ticker() {
        application.cells.buttons["XXX \\ ZZZ"].tap()
        
        XCTAssertEqual("- \\ -", application.navigationBars.firstMatch.identifier)
        XCTAssertTrue(application.staticTexts["No data"].exists)
    }
    
    private func assertRow(
        expectedLabel: String,
        expectedValue: String
    ) {
        let detailRow = application.cells.otherElements[expectedLabel]
        
        XCTAssertEqual(expectedLabel, detailRow.label)
        XCTAssertEqual(expectedValue, detailRow.value as! String)
    }
    
}
