import SwiftUI

struct TickerAdder: View {
    
    @EnvironmentObject private var userData: UserData
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.availableTickersIdentifiersToAdd) { tickerIdentifier in
                    AdderRow(text: tickerIdentifier.title)
                        .padding(.top)
                        .padding(.bottom)
                        .onTapGesture {
                            self.userData.appendTicker(from: tickerIdentifier)
                            self.isPresented.toggle()
                        }
                }
            }
            .navigationBarTitle(Text("add.ticker.title"))
        }
    }
    
}

#if DEBUG
struct TickerAdder_Previews: PreviewProvider {
    
    static var previews: some View {
        TickerAdder(isPresented: .constant(true))
    }
    
}
#endif
