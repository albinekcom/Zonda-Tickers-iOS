import XCTest

final class DetailUITests: UITests {
    
    func test_filled_ticker_btc_pln() {
        assertDetail(
            tickerLabel: "BTC \\ PLN",
            expectedRowsValue: [
                "Bitcoin",
                "3.00",
                "-5.00",
                "-62.50%",
                "4.00",
                "5.00",
                "6.00",
                "1.00",
                "2.00",
                "5.00",
                "7",
                "21.00"
            ]
        )
    }
    
    func test_empty_ticker_xxx_zzz() {
        assertDetail(
            tickerLabel: "XXX \\ ZZZ",
            expectedRowsValue: [
                "-",
                "-",
                "-",
                "-",
                "-",
                "-",
                "-",
                "-",
                "-",
                "-",
                "-",
                "-"
            ]
        )
    }
    
    private func assertDetail(
        tickerLabel: String,
        expectedRowsValue: [String]
    ) {
        application.cells.buttons[tickerLabel].tap()
        
        XCTAssertEqual(tickerLabel, application.navigationBars.firstMatch.identifier)
        
        assertRow(expectedLabel: "Name", expectedValue: expectedRowsValue[0])
        assertRow(expectedLabel: "Rate", expectedValue: expectedRowsValue[1])
        assertRow(expectedLabel: "Change", expectedValue: expectedRowsValue[2])
        assertRow(expectedLabel: "Change (%)", expectedValue: expectedRowsValue[3])
        assertRow(expectedLabel: "Previous rate", expectedValue: expectedRowsValue[4])
        assertRow(expectedLabel: "Highest rate", expectedValue: expectedRowsValue[5])
        assertRow(expectedLabel: "Lowest rate", expectedValue: expectedRowsValue[6])
        
        application.swipeUp()
        
        assertRow(expectedLabel: "Bid", expectedValue: expectedRowsValue[7])
        assertRow(expectedLabel: "Ask", expectedValue: expectedRowsValue[8])
        assertRow(expectedLabel: "Average", expectedValue: expectedRowsValue[9])
        assertRow(expectedLabel: "Volume", expectedValue: expectedRowsValue[10])
        assertRow(expectedLabel: "Volume value", expectedValue: expectedRowsValue[11])
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
