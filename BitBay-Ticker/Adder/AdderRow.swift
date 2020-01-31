import SwiftUI

struct AdderRow: View {
    
    let firstCurrency: String
    let secondCurrency: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                CurrencyIcon(currencyName: self.firstCurrency)
                    .frame(width: geometry.size.height * 0.5, height: geometry.size.height * 0.5)
                Title(firstCurrency: self.firstCurrency, secondCurrency: self.secondCurrency)
                    .padding(.horizontal, 2)
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(Color.applicationPrimary)
                    .font(.headline)
            }
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
