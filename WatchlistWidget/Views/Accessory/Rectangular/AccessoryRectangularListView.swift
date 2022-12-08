import SwiftUI

struct AccessoryRectangularListView: View {
    
    private let models: [Ticker?]
    private let maximumCount: Int
    
    init(
        tickers: [Ticker]?,
        maximumCount: Int
    ) {
        if let tickers = tickers {
            models = tickers.count < maximumCount ? tickers : Array(tickers[..<maximumCount])
        } else {
            models = (0..<maximumCount).map { _ in nil }
        }
        
        self.maximumCount = maximumCount
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ForEach(models, id: \.modelId) {
                    AccessoryRectangularRowView(ticker: $0)
                        .frame(height: proxy.size.height / CGFloat(maximumCount))
                }
                
                Spacer()
            }
        }
    }
    
}

private extension Optional where Wrapped == Ticker {
    
    var modelId: String { self?.id ?? "placeholder" }
    
}
