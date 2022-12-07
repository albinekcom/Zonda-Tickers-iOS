import SwiftUI

struct SystemSmallRowView: View {
    
    let model: StandardRowView.Model
    
    var body: some View {
        HStack(spacing: 0) {
            titleLabel
            Spacer()
            values
        }
    }
    
    private var titleLabel: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.firstCurrencyText)
                .font(.callout)
            Text("\\ \(model.secondCurrencyText)")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .layoutPriority(1)
    }
    
    private var values: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(model.rateText)
                .font(.callout)
            Text(model.percentageChangeWithPositiveSignText)
                .font(.caption)
                .foregroundColor(model.changeColor)
        }
        .lineLimit(1)
    }
    
}
