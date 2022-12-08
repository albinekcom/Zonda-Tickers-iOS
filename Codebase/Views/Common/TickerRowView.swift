import SwiftUI

struct TickerRowView: View {
    
    let ticker: Ticker?
    
    var body: some View {
        HStack {
            titleLabel
            Spacer()
            values
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(ticker.title)
        .accessibilityValue(ticker.rateText)
    }
    
    private var titleLabel: some View {
        HStack {
            CurrencyLogoView(currencyId: ticker?.firstCurrency.id)
                .frame(maxWidth: 32, maxHeight: 32)
            
            HStack(alignment: .top, spacing: 4) {
                Text(ticker.firstCurrencyText)
                    .font(.headline)
                Text("\\ \(ticker.secondCurrencyText)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .layoutPriority(1)
    }
    
    private var values: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(ticker.rateText)
                .font(.headline)
            HStack {
                Image(systemName: ticker.changeImageName)
                    .imageScale(.small)
                    .rotationEffect(.radians(ticker.change > 0 ? 0 : .pi))
                Text(ticker.percentageChangeWithoutSignText)
                    .font(.subheadline)
            }
            .foregroundColor(ticker.changeColor)
        }
        .lineLimit(1)
    }
    
}

#if DEBUG && !TESTING

struct TickerRowView_Previews: PreviewProvider {

    static var previews: some View {
        TickerRowView(ticker: .init(
            firstCurrency: .init(id: "btc"),
            secondCurrency: .init(id: "pln"),
            rate: 123.45,
            average: 100
        ))
    }

}

#endif
