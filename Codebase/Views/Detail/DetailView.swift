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
                List(ticker.detailRowModels) {
                    DetailRowView(model: $0)
                }
                .animation(.default, value: ticker)
            } else {
                Text("This Ticker is no longer supported")
            }
        }
        .navigationTitle(ticker.name)
        .onAppear { appEnvironment.analyticsService.trackView(tickerId: tickerId) }
    }
    
}

private extension Ticker {
    
    var detailRowModels: [DetailRowView.Model] {
        [
            .init(title: "Name", value: firstCurrencyName),
            .init(title: "Rate", value: rateText),
            .init(title: "Change", value: changeText, valueColor: changeColor),
            .init(title: "Change (%)", value: percentageChangeWithPositiveSignText, valueColor: changeColor),
            .init(title: "Previous rate", value: previousRateText),
            .init(title: "Highest rate", value: highestRateText),
            .init(title: "Lowest rate", value: lowestRateText),
            .init(title: "Bid", value: highestBidText),
            .init(title: "Ask", value: lowestAskText),
            .init(title: "Average", value: averageText),
            .init(title: "Volume", value: volumeText),
            .init(title: "Volume value", value: volumeValueText)
        ]
    }
    
}
