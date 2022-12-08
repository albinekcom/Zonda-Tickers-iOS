import XCTest
@testable import Zonda_Tickers

final class Ticker_DetailRowViewModelsTests: XCTestCase {
    
    func test_detailRowViewModels() {
        XCTAssertEqual([
            .init(title: "Name", valueText: "Bitcoin"),
            .init(title: "Rate", valueText: "3.00"),
            .init(title: "Change", valueText: "-5.00", valueColor: .red),
            .init(title: "Change (%)", valueText: "-62.50%", valueColor: .red),
            .init(title: "Previous rate", valueText: "4.00"),
            .init(title: "Highest rate", valueText: "5.00"),
            .init(title: "Lowest rate", valueText: "6.00"),
            .init(title: "Bid", valueText: "1.00"),
            .init(title: "Ask", valueText: "2.00"),
            .init(title: "Average", valueText: "8.00"),
            .init(title: "Volume", valueText: "7"),
            .init(title: "Volume value", valueText: "21.00")
        ], Ticker.stub1.detailRowViewModels)
    }

}
