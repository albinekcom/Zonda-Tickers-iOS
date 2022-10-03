import SwiftUI

struct StandardRow: View {
    
    let model: Model
    
    var body: some View {
        HStack {
            titleLabel
            Spacer()
            values
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(model.name)
        .accessibilityValue(model.rateText)
    }
    
    private var titleLabel: some View {
        HStack {
            CurrencyLogo(currencyId: model.firstCurrencyId)
                .frame(maxWidth: 32, maxHeight: 32)
            
            HStack(alignment: .top, spacing: 4) {
                Text(model.firstCurrencyText)
                    .font(.headline)
                Text("\\ \(model.secondCurrencyText)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .layoutPriority(1)
    }
    
    private var values: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(model.rateText)
                .font(.headline)
            HStack {
                Image(systemName: model.changeImageName)
                    .imageScale(.small)
                    .rotationEffect(.radians(model.changeColor == .red ? .pi : 0))
                Text(model.percentageChangeWithoutSignText)
                    .font(.subheadline)
            }
            .foregroundColor(model.changeColor)
        }
        .lineLimit(1)
    }
    
}

extension StandardRow {
    
    struct Model: Equatable {
        
        let firstCurrencyId: String?
        let firstCurrencyText: String
        let secondCurrencyText: String
        let rateText: String
        let percentageChangeWithoutSignText: String
        let percentageChangeWithPositiveSignText: String
        let changeImageName: Image.SystemName
        let changeColor: Color
        
        var name: String {
            firstCurrencyText + " \\ " + secondCurrencyText
        }
        
    }
    
}

#if DEBUG && !TESTING

struct StandardRow_Previews: PreviewProvider {

    static var previews: some View {
        StandardRow(model: .init(
            firstCurrencyId: "btc",
            firstCurrencyText: "BTC",
            secondCurrencyText: "PLN",
            rateText: "123.45",
            percentageChangeWithoutSignText: "123.45",
            percentageChangeWithPositiveSignText: "22.33",
            changeImageName: .arrowTriangleUpFill,
            changeColor: .orange
        ))
    }

}

#endif
