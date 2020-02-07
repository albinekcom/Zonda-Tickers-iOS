import SwiftUI

struct TickerAdderEmpty: View {
    
    var body: some View {
        Text("No results")
            .font(.subheadline)
            .foregroundColor(.primary)
    }
    
}

#if DEBUG
struct TickerAdderEmpty_Previews: PreviewProvider {
    
    static var previews: some View {
        TickerAdderEmpty()
    }
    
}
#endif
