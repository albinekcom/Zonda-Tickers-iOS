import SwiftUI
import WidgetKit

struct AccessoryCircularView: View {
    
    let tickers: [Ticker]?
    
    var body: some View {
        ZStack {
            if #available(iOSApplicationExtension 16.0, *) {
                AccessoryWidgetBackground()
            } else {
                Circle().fill(.quaternary)
            }
            
            if tickers?.isEmpty == true {
                NoTickersView()
                    .multilineTextAlignment(.center)
            } else {
                VStack {
                    Image(systemName: ticker.changeImageName.rawValue)
                    Text(ticker.shortName)
                    Text(ticker.percentageChangeWithoutSignText)
                }
            }
        }
        .font(.caption)
    }
    
    private var ticker: Ticker? {
        tickers?.first
    }
    
}

private extension Optional where Wrapped == Ticker {
    
    var changeImageName: Image.SystemName {
        self?.changeImageName ?? .squareFill
    }
    
    var shortName: String {
        (self?.firstCurrencyText ?? "-") + "\\" + (self?.secondCurrencyText ?? "-")
    }
    
    var percentageChangeWithoutSignText: String {
        self?.percentageChangeWithoutSignText ?? "-"
    }
    
}
