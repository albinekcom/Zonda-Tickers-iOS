import SwiftUI

struct AccessoryInlineView: View {
    
    let tickers: [Ticker]?
    
    var body: some View {
        if tickers?.isEmpty == true {
            NoTickersView()
        } else {
            HStack {
                Image(systemName: ticker.changeImageName)
                    .rotationEffect(.radians(ticker.change > 0 ? 0 : .pi))
                    .foregroundColor(ticker.changeColor)
                ticker.intlineText
            }
        }
    }
    
    private var ticker: Ticker? {
        tickers?.first
    }
    
}

private extension Optional where Wrapped == Ticker {
    
    var intlineText: Text {
        guard let self = self else { return Text("-\\- " + "-") }
        
        return Text(self.shortTitle + " ") + Text(self.percentageChangeWithPositiveSignText).foregroundColor(self.changeColor)
    }
    
}
