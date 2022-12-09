import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject private var modelData: ModelData
    @EnvironmentObject private var appEnvironment: AppEnvironment
    
    let tickerId: String
    
    private var ticker: Ticker? {
        modelData.ticker(id: tickerId)
    }
    
    var body: some View {
        Group {
            if let ticker = ticker {
                List(ticker.detailRowViewModels) {
                    DetailRowView(model: $0)
                }
                .animation(.default, value: ticker)
            } else {
                Text("No data")
            }
        }
        .navigationTitle(ticker.title)
        .onAppear { appEnvironment.analyticsService.trackView(tickerId: tickerId) }
    }
    
}
