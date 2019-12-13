import SwiftUI

struct AdderRow: View {
    
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "plus.circle.fill")
            Text(text)
            Spacer()
        }
    }
    
}

#if DEBUG
struct AdderRow_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            AdderRow(text: "BTC-PLN")
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
    
}
#endif
