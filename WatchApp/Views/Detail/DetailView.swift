import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject private var modelData: ModelData
    
    let tickerId: String
    
    private var ticker: Ticker? {
        modelData.userTickers.ticker(id: tickerId)
    }
    
    var body: some View {
        Group {
            if let ticker = ticker {
                List(ticker.detailRowViewModels) {
                    DetailRowView(model: $0)
                }
                .animation(.default, value: ticker)
            } else {
                Text("This Ticker is no longer supported")
            }
        }
        .navigationTitle(ticker.title)
    }
    
}

#if DEBUG && !TESTING

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(tickerId: "btc-pln")
            .environmentObject(ModelData())
    }
    
}

#endif
