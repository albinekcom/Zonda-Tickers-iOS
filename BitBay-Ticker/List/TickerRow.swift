import SwiftUI

struct TickerRow: View {
    
    var ticker: Ticker
    
    var body: some View {
        HStack {
            Text(ticker.title)
            Spacer()
            Text("\(ticker.previousRate ?? 0)")
        }
    }
    
}

#if DEBUG
struct TickerRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let firstCurrency = Currency(currency: "BTC", minimumOffer: 0.0001, scale: 3)
        let secondCurrency = Currency(currency: "PLN", minimumOffer: 0.01, scale: 2)
        let ticker = Ticker(id: "BTC-PLN", firstCurrency: firstCurrency, secondCurrency: secondCurrency, highestBid: 123, lowestAsk: 456, rate: 789, previousRate: 123)
        
        return Group {
            TickerRow(ticker: ticker)
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
    
}
#endif
