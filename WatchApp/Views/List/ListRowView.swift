import SwiftUI

struct ListRowView: View {
    
    let ticker: Ticker
    
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

#if DEBUG && !TESTING

struct ListRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        ListRowView(ticker: .init(
            firstCurrency: .init(id: "btc"),
            secondCurrency: .init(id: "pln"),
            rate: 123.45,
            average: 100
        ))
    }
    
}

#endif
