import SwiftUI

struct ListView: View {
    
    @EnvironmentObject private var modelData: ModelData
    @StateObject private var automaticMethodInvoker = AutomaticMethodInvoker()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        content
            .navigationTitle("Tickers")
            .onAppear {
                automaticMethodInvoker.invokeMethod = { await modelData.refresh() }
                automaticMethodInvoker.start()
            }
            .onChange(of: scenePhase) {
                guard $0 == .active else { return }
                
                modelData.reloadTickers()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if modelData.userTickers.isEmpty {
            NoTickersView()
        } else {
            List {
                ForEach(modelData.userTickers) { ticker in
                    NavigationLink {
                        DetailView(tickerId: ticker.id)
                            .environmentObject(modelData)
                    } label: {
                        ListRowView(ticker: ticker)
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
