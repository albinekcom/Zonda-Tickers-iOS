import SwiftUI

struct TickerAdder: View {
    
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.availableTickersIdentifiersToAdd) { tickerIdentifier in
                    AdderRow(text: tickerIdentifier.title)
                        .padding(.top)
                        .padding(.bottom)
                }
            }
            .navigationBarTitle(Text("add.ticker.title"))
        }
    }
    
}

#if DEBUG
struct TickerAdder_Previews: PreviewProvider {
    
    static var previews: some View {
        TickerAdder()
    }
    
}
#endif
