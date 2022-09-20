import SwiftUI

struct TickerRow: View {
    
    let ticker: Ticker
    
    var body: some View {
        StandardRow(model: ticker.standardRowModel)
    }
    
}
