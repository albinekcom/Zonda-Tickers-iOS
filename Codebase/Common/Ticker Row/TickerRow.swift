import SwiftUI

struct TickerRow: View {
    
    let viewModel: TickerRowViewModel
    
    var body: some View {
        HStack {
            title
            Spacer()
            values
        }
    }
    
    private var title: some View {
        HStack {
            Group {
                if let _ = UIImage(named: viewModel.firstCurrencyId.lowercased()) {
                    Image(viewModel.firstCurrencyId.lowercased())
                        .resizable()
                } else {
                    CurrencyLetterIcon(currencyId: viewModel.firstCurrencyId)
                }
            }
            .frame(maxWidth: 32, maxHeight: 32)

            HStack(alignment: .top, spacing: 4) {
                Text(viewModel.firstCurrencyId)
                    .font(.headline)
                Text("\\ \(viewModel.secondCurrencyId)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .layoutPriority(1)
    }
    
    private var values: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(viewModel.rateString)
                .font(.headline)
            HStack(spacing: 4) {
                TrendIcon(trendIconStyle: viewModel.trendIconStyle)
                    .frame(width: 12, height: 12)
                    .foregroundColor(viewModel.changeRatioStringColorStyle.color)
                Text(viewModel.changeRatioString)
                    .font(.subheadline)
                    .foregroundColor(viewModel.changeRatioStringColorStyle.color)
            }
        }
        .lineLimit(1)
    }
    
}

private struct CurrencyLetterIcon: View {
    
    let currencyId: String
    
    private var firstLetter: String {
        guard let firstLetter = currencyId.first else { return "-" }
        
        return String(firstLetter.uppercased())
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(currencyId.generatedColor)
            Text(firstLetter)
                .font(.headline)
                .foregroundColor(.white)
        }
    }
    
}

#if DEBUG

struct TickerRow_Previews: PreviewProvider {
    
    static var previews: some View {
        TickerRow(
            viewModel: .init(
                ticker: .init(
                    id: "btc-pln",
                    firstCurrency: .init(
                        id: "btc",
                        name: "Bitcoin",
                        precision: 8
                    ),
                    secondCurrency: .init(
                        id: "pln",
                        name: "Złoty",
                        precision: 2
                    ),
                    highestBid: 11.11,
                    lowestAsk: 22.22,
                    rate: 33.33,
                    previousRate: 44.44,
                    highestRate: 55.55,
                    lowestRate: 66.66,
                    volume: 77.77,
                    average: 88.88
                )
            )
        )
    }
    
}

#endif
