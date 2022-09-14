import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject private var modelData: ModelData
    @EnvironmentObject private var appEnvironment: AppEnvironment
    
    let tickerId: String
    
    var body: some View {
        List {
            mainValues
            otherValues
        }
        .animation(.default, value: modelData.availableTickers)
        .navigationTitle(tickerId.navigationTitle)
        .onAppear { appEnvironment.analyticsService.trackView(tickerId: tickerId) }
    }
    
    private var ticker: Ticker? {
        modelData.ticker(for: tickerId)
    }
    
    @ViewBuilder
    private var mainValues: some View {
        DetailRow(
            title: "Name",
            value: ticker?.firstCurrency.name ?? "-",
            valueColor: .secondary
        )
        DetailRow(
            title: "Rate",
            value: ticker?.rate?.pretty(precision: ticker?.secondCurrency.precision) ?? "-",
            valueColor: .secondary
        )
        DetailRow(
            title: "Change",
            value: ticker?.change?.pretty(precision: ticker?.secondCurrency.precision, positivePrefix: "+") ?? "-",
            valueColor: ticker?.change?.color ?? .secondary
        )
        DetailRow(
            title: "Change (%)",
            value: ticker?.changeRatio?.pretty(precision: 2, numberStyle: .percent, positivePrefix: "+") ?? "-",
            valueColor: ticker?.change?.color ?? .secondary
        )
    }
    
    @ViewBuilder
    private var otherValues: some View {
        DetailRow(
            title: "Previous rate",
            value: ticker?.previousRate?.pretty(precision: ticker?.secondCurrency.precision) ?? "-",
            valueColor: .secondary
        )
        DetailRow(
            title: "Highest rate",
            value: ticker?.highestRate?.pretty(precision: ticker?.secondCurrency.precision) ?? "-",
            valueColor: .secondary
        )
        
        DetailRow(
            title: "Lowest rate",
            value: ticker?.lowestRate?.pretty(precision: ticker?.secondCurrency.precision) ?? "-",
            valueColor: .secondary
        )
        
        DetailRow(
            title: "Bid",
            value: ticker?.highestBid?.pretty(precision: ticker?.secondCurrency.precision) ?? "-",
            valueColor: .secondary
        )
        
        DetailRow(
            title: "Ask",
            value: ticker?.lowestAsk?.pretty(precision: ticker?.secondCurrency.precision) ?? "-",
            valueColor: .secondary
        )
        
        DetailRow(
            title: "Average",
            value: ticker?.highestRate?.pretty(precision: ticker?.secondCurrency.precision) ?? "-",
            valueColor: .secondary
        )
        
        DetailRow(
            title: "Volume",
            value: ticker?.volume?.pretty(precision: nil) ?? "-",
            valueColor: .secondary
        )
        
        DetailRow(
            title: "Volume value",
            value: ticker?.volumeValue?.pretty(precision: ticker?.secondCurrency.precision) ?? "-",
            valueColor: .secondary
        )
    }
    
}

private extension String {
    
    var navigationTitle: String {
        let currenciesId = components(separatedBy: "-")
        
        let firstCurrencyId = currenciesId.first ?? "-"
        let secondCurrencyId = currenciesId.last ?? "-"
        
        return "\(firstCurrencyId) \\ \(secondCurrencyId)".uppercased()
    }
    
}

#if DEBUG

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(tickerId: "btc-pln")
    }
    
}

#endif
