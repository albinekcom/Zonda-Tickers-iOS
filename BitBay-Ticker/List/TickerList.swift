import SwiftUI

struct TickerList: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Hello, Ticker List!")
        }
    }
    
}

#if DEBUG
struct TickerList_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
           TickerList()
              .environment(\.colorScheme, .light)
        }
    }
    
}
#endif
