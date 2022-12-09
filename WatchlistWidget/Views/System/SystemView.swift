import SwiftUI

struct SystemView: View {
    
    let tickers: [Ticker]?
    let tickersMaximumCount: Int
    let isSystemSmall: Bool
    
    var body: some View {
        if tickers?.isEmpty == true {
            NoTickersView()
        } else {
            SystemListView(
                tickers: tickers,
                tickersMaximumCount: tickersMaximumCount,
                isSystemSmall: isSystemSmall
            )
        }
    }
    
}
