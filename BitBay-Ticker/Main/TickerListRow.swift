import SwiftUI

struct TickerListRow: View {
    
    let firstCurrency: String
    let secondCurrency: String
    let value: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                CurrencyIcon(currencyName: self.firstCurrency)
                    .frame(width: geometry.size.height * 0.5, height: geometry.size.height * 0.5)
                Title(firstCurrency: self.firstCurrency, secondCurrency: self.secondCurrency)
                    .padding(.horizontal, 2)
                Spacer()
                Text(self.value)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
    }
    
}

struct MainTitle: View {
    
    let firstCurrency: String
    let secondCurrency: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(firstCurrency)
                .font(.title)
                .foregroundColor(.primary)
            Text("/ \(secondCurrency)")
                .font(.callout)
                .foregroundColor(.secondary)
        }
    }
    
}

#if DEBUG
struct TickerListRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let firstCurrency = "BAT"
        let secondCurrency = "PLN"
        let value = "123.34 PLN"
        
        return Group {
            TickerListRow(firstCurrency: firstCurrency, secondCurrency: secondCurrency, value: value)
                .previewLayout(.fixed(width: 400, height: 70))
                .environment(\.colorScheme, .light)
            TickerListRow(firstCurrency: firstCurrency, secondCurrency: secondCurrency, value: value)
                .previewLayout(.fixed(width: 400, height: 70))
                .environment(\.colorScheme, .dark)
        }
    }
    
}
#endif
