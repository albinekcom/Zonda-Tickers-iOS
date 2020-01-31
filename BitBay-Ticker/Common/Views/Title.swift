import SwiftUI

struct Title: View {
    
    let firstCurrency: String
    let secondCurrency: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(firstCurrency)
                .font(.headline)
                .foregroundColor(.primary)
            Text("/ \(secondCurrency)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
    
}

#if DEBUG
struct Title_Previews: PreviewProvider {
    
    static var previews: some View {
        Title(firstCurrency: "BAT", secondCurrency: "PLN")
    }
    
}
#endif
