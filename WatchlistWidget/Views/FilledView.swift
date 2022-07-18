import SwiftUI

struct FilledView: View {
    
    let tickers: [Ticker]
    let maximumCount: Int
    let isSimpleTickerRowUsed: Bool
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ForEach(tickers) { ticker in
                    row(for: ticker)
                        .padding(.horizontal, isSimpleTickerRowUsed ? 8 : 16)
                        .frame(height: proxy.size.height / CGFloat(maximumCount))
                }
                Spacer()
            }
            
        }
    }
    
    @ViewBuilder
    private func row(for ticker: Ticker) -> some View {
        if isSimpleTickerRowUsed {
            ticker.simpleTickerRow
        } else {
            ticker.tickerRow
        }
    }
    
}

private extension Ticker {
    
    var simpleTickerRow: SimpleTickerRow {
        .init(
            firstCurrencyId: firstCurrency.id,
            secondCurrencyId: secondCurrency.id,
            rate: rate,
            ratePrecision: secondCurrency.precision,
            changeRatio: changeRatio
        )
    }
}

