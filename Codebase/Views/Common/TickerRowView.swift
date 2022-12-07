import SwiftUI

struct TickerRowView: View {
    
    let ticker: Ticker
    
    var body: some View {
        StandardRowView(model: ticker.standardRowModel)
    }
    
}
