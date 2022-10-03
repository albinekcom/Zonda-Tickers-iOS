import SwiftUI

struct ListView: View {
    
    @EnvironmentObject private var userTickerStore: UserTickerStore
    @StateObject private var automaticMethodInvoker = AutomaticMethodInvoker()
    
    var body: some View {
        content
            .navigationTitle("Tickers")
            .onAppear {
                automaticMethodInvoker.invokeMethod = { await userTickerStore.refresh() }
                automaticMethodInvoker.start()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if userTickerStore.tickers.isEmpty {
            Text("No Tickers")
        } else {
            List {
                ForEach(userTickerStore.tickers) { ticker in
                    NavigationLink {
                        DetailView(tickerId: ticker.id)
                            .environmentObject(userTickerStore)
                    } label: {
                        TickerRow(ticker: ticker)
                    }
                }
            }
        }
    }
    
}

#if DEBUG && !TESTING

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ListView()
                .environmentObject(UserTickerStore())
        }
    }
    
}

#endif
