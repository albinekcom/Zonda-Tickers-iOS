import SwiftUI

struct DetailView: View {
    
    let tickerId: String
    
    @EnvironmentObject private var userTickerStore: UserTickerStore
    
    private var ticker: Ticker? {
        userTickerStore.tickers.ticker(id: tickerId)
    }
    
    var body: some View {
        Group {
            if let ticker = ticker {
                List(ticker.detailRowModels) {
                    DetailRow(model: $0)
                }
                .animation(.default, value: ticker)
            } else {
                Text("This Ticker is no longer supported")
            }
        }
        .navigationTitle(ticker.name)
    }
    
}

private extension Ticker {
    
    var detailRowModels: [DetailRow.Model] {
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

#if DEBUG && !TESTING

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(tickerId: "btc-pln")
            .environmentObject(UserTickerStore())
    }
    
}

#endif
