import SwiftUI

struct AdderRow: View {
    
    let firstCurrency: String
    let secondCurrency: String
    
    var body: some View {
        HStack {
            CurrencyIcon(currencyName: firstCurrency)
            Title(firstCurrency: firstCurrency, secondCurrency: secondCurrency)
                .padding(.horizontal, 4)
            Spacer()
            Image(systemName: "plus.circle.fill")
                .foregroundColor(Color.applicationPrimary)
                .font(.headline)
        }
    }
    
}

#if DEBUG
struct AdderRow_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color(.black)
            AdderRow(firstCurrency: "BAT", secondCurrency: "PLN")
        }
        .previewLayout(.fixed(width: 400, height: 70))
        .environment(\.colorScheme, .dark)
    }
    
}
#endif
