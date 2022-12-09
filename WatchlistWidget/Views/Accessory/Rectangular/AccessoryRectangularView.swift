import SwiftUI

struct AccessoryRectangularView: View {
    
    let tickers: [Ticker]?
    let tickersMaximumCount: Int
    
    var body: some View {
        if tickers?.isEmpty == true {
            NoTickersView()
        } else {
            AccessoryRectangularListView(
                tickers: tickers,
                tickersMaximumCount: tickersMaximumCount
            )
        }
    }
    
}
