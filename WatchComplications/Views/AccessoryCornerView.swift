import SwiftUI

struct AccessoryCornerView: View {
    
    let tickers: [Ticker]?
    
    var body: some View {
        Text(ticker.firstCurrencyText)
            .font(.largeTitle)
            .bold()
            .widgetLabel {
                if tickers?.isEmpty == true {
                    NoTickersView()
                } else {
                    ticker.intlineText
                }
            }
    }
    
    private var ticker: Ticker? {
        tickers?.first
    }
    
}

private extension Optional where Wrapped == Ticker {
    
    var firstCurrencyText: String {
        guard let self = self else { return "-" }
        
        return self.firstCurrencyText
    }
    
    var intlineText: Text {
        guard let self = self else { return Text("\\" + "- -") }
        
        return Text("\\" + self.secondCurrencyText + " ") + Text(self.percentageChangeWithPositiveSignText).foregroundColor(self.changeColor)
    }
    
}
