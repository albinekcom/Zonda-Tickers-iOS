import SwiftUI

struct SystemListView: View {
    
    private let models: [Ticker?]
    private let maximumCount: Int
    private let isSystemSmall: Bool
    
    init(
        tickers: [Ticker]?,
        maximumCount: Int,
        isSystemSmall: Bool
    ) {
        models = (0...maximumCount).map { tickers?[$0] }
        self.maximumCount = maximumCount
        self.isSystemSmall = isSystemSmall
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ForEach(models, id: \.modelId) { ticker in
                    Group {
                        if isSystemSmall {
                            SystemSmallTickerRowView(ticker: ticker)
                        } else {
                            TickerRowView(ticker: ticker)
                        }
                    }
                    .frame(height: proxy.size.height / CGFloat(maximumCount))
                    .padding(.horizontal)
                    
                    Divider()
                }
                Spacer()
            }
        }
    }
    
}

private extension Optional where Wrapped == Ticker {
    
    var modelId: String { self?.id ?? "placeholder" }
    
}
