import SwiftUI

struct AccessoryRectangularListView: View {
    
    private let models: [Ticker?]
    private let tickersMaximumCount: Int
    
    init(
        tickers: [Ticker]?,
        tickersMaximumCount: Int
    ) {
        if let tickers = tickers {
            models = tickers.count < tickersMaximumCount ? tickers : Array(tickers[..<tickersMaximumCount])
        } else {
            models = (0..<tickersMaximumCount).map { _ in nil }
        }
        
        self.tickersMaximumCount = tickersMaximumCount
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ForEach(models, id: \.self) {
                    AccessoryRectangularRowView(ticker: $0)
                        .frame(height: proxy.size.height / CGFloat(tickersMaximumCount))
                }
                
                Spacer()
            }
        }
    }
    
}
