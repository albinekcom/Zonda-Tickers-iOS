import SwiftUI

struct TickerRow: View {
    
    var ticker: Ticker
    
    var body: some View {
        HStack {
            Text(ticker.title)
            Spacer()
            Text("\(ticker.rate ?? 0)")
        }
    }
    
}

#if DEBUG
struct TickerRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let ticker = Ticker(id: "BTC-PLN", rate: 789)
        
        return Group {
            TickerRow(ticker: ticker)
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
    
}
#endif
