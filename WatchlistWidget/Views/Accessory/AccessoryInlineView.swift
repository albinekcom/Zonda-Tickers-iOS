import SwiftUI

struct AccessoryInlineView: View {
    
    let tickers: [Ticker]?
    
    var body: some View {
        if tickers?.isEmpty == true {
            NoTickersView()
        } else {
            HStack {
                Image(systemName: ticker.changeImageName)
                    .rotationEffect(.radians((ticker?.change ?? 0) > 0 ? 0 : .pi))
                Text(ticker.intlineText)
            }
        }
    }
    
    private var ticker: Ticker? {
        tickers?.first
    }
    
}

private extension Optional where Wrapped == Ticker {
    
    var intlineText: String {
        guard let self = self else { return "-\\- -" }
        
        return self.firstCurrencyText + "\\" + self.secondCurrencyText + " " + self.percentageChangeWithPositiveSignText
    }
    
    var changeImageName: Image.SystemName {
        self?.changeImageName ?? .squareFill
    }
    
}
