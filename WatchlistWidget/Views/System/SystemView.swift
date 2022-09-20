import SwiftUI

struct SystemView: View {
    
    let tickers: [Ticker]?
    let maximumCount: Int
    let isSystemSmall: Bool
    
    var body: some View {
        if tickers?.isEmpty == true {
            NoTickersView()
        } else {
            SystemListView(
                tickers: tickers,
                maximumCount: maximumCount,
                isSystemSmall: isSystemSmall
            )
        }
    }
    
}
