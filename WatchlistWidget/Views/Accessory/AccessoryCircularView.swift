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
                    Image(systemName: ticker.changeImageName)
                        .rotationEffect(.radians(ticker.change > 0 ? 0 : .pi))
                        .foregroundColor(ticker.changeColor)
                    Text(ticker.shortTitle)
                    Text(ticker.percentageChangeWithoutSignText)
                        .foregroundColor(ticker.changeColor)
                }
            }
        }
        .font(.caption)
    }
    
    private var ticker: Ticker? {
        tickers?.first
    }
    
}
