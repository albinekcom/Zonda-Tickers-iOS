import SwiftUI

struct SystemSmallTickerRowView: View {
    
    let ticker: Ticker?
    
    var body: some View {
        HStack(spacing: 0) {
            titleLabel
            Spacer()
            values
        }
    }
    
    private var titleLabel: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(ticker.firstCurrencyText)
                .font(.callout)
            Text("\\ \(ticker.secondCurrencyText)")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .layoutPriority(1)
    }
    
    private var values: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(ticker.rateText)
                .font(.callout)
            Text(ticker.percentageChangeWithPositiveSignText)
                .font(.caption)
                .foregroundColor(ticker.changeColor)
        }
        .lineLimit(1)
    }
    
}
