import SwiftUI

struct SimpleTickerRow: View {
    
    let firstCurrencyId: String
    let secondCurrencyId: String
    let rate: Double?
    let ratePrecision: Int
    let changeRatio: Double?
    
    var body: some View {
        HStack(spacing: 0) {
            titleLabel
            Spacer()
            values
        }
    }
    
    private var titleLabel: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(firstCurrencyId.uppercased())
                .font(.callout)
            Text("\\ \(secondCurrencyId.uppercased())")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .layoutPriority(1)
    }
    
    private var values: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(rate?.pretty(precision: ratePrecision) ?? "-")
                .font(.callout)
            Text(changeRatio?.pretty(precision: 2, numberStyle: .percent, positivePrefix: "+") ?? "-")
                .font(.caption)
                .foregroundColor(changeRatio?.color ?? .secondary)
        }
        .lineLimit(1)
    }
    
}
