import SwiftUI

struct TickerListRow: View {
    
    let firstCurrency: String
    let secondCurrency: String
    let value: String
    
    var body: some View {
        HStack {
            CurrencyIcon(currencyName: self.firstCurrency)
            Title(firstCurrency: self.firstCurrency, secondCurrency: self.secondCurrency)
                .padding(.horizontal, 4)
            Spacer()
            Text(self.value)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .accessibility(label: Text("Ticker \(firstCurrency)\\\(secondCurrency)"))
        .accessibility(value: Text(value))
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
