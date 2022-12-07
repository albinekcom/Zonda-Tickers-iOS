import SwiftUI

struct ListView: View {
    
    @EnvironmentObject private var modelData: ModelData
    @StateObject private var automaticMethodInvoker = AutomaticMethodInvoker()
    
    var body: some View {
        content
            .navigationTitle("Tickers")
            .onAppear {
                automaticMethodInvoker.invokeMethod = { await modelData.refresh() }
                automaticMethodInvoker.start()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if modelData.userTickers.isEmpty {
            Text("No Tickers")
        } else {
            List {
                ForEach(modelData.userTickers) { ticker in
                    NavigationLink {
                        DetailView(tickerId: ticker.id)
                    } label: {
                        TickerRowView(ticker: ticker)
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
                .environmentObject(ModelData())
        }
    }
    
}

#endif
