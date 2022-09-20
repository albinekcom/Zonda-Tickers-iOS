import SwiftUI

struct AccessoryInlineView: View {
    
    let tickers: [Ticker]?
    
    var body: some View {
        if tickers?.isEmpty == true {
            NoTickersView()
        } else {
            Label(
                ticker.intlineText,
                systemImage: ticker.changeImageName.rawValue
            )
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
