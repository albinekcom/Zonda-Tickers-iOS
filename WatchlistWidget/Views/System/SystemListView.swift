import SwiftUI

struct SystemListView: View {
    
    private let models: [Ticker?]
    private let tickersMaximumCount: Int
    private let isSystemSmall: Bool
    
    init(
        tickers: [Ticker]?,
        tickersMaximumCount: Int,
        isSystemSmall: Bool
    ) {
        if let tickers = tickers {
            models = tickers.count < tickersMaximumCount ? tickers : Array(tickers[..<tickersMaximumCount])
        } else {
            models = (0..<tickersMaximumCount).map { _ in nil }
        }
        
        self.tickersMaximumCount = tickersMaximumCount
        self.isSystemSmall = isSystemSmall
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ForEach(models, id: \.self) { ticker in
                    Group {
                        if isSystemSmall {
                            SystemSmallTickerRowView(ticker: ticker)
                        } else {
                            TickerRowView(ticker: ticker)
                        }
                    }
                    .frame(height: proxy.size.height / CGFloat(tickersMaximumCount))
                    .padding(.horizontal)
                    
                    Divider()
                }
                Spacer()
            }
        }
    }
    
}
