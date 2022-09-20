import SwiftUI

struct AccessoryRectangularView: View {
    
    let tickers: [Ticker]?
    let maximumCount: Int
    
    var body: some View {
        if tickers?.isEmpty == true {
            NoTickersView()
        } else {
            AccessoryRectangularListView(
                tickers: tickers,
                maximumCount: maximumCount
            )
        }
    }
    
}
