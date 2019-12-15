import SwiftUI

struct AdderRow: View {
    
    let text: Text
    
    var body: some View {
        HStack {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.primary)
            text
            Spacer()
        }
    }
    
}

#if DEBUG
struct AdderRow_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            AdderRow(text: Text("BTC-PLN"))
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
    
}
#endif
