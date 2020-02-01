import SwiftUI

struct WidgetView : View {
    
    @EnvironmentObject private var widgetUserData: WidgetUserData
    
    var body: some View {
        List(widgetUserData.tickers) { (ticker) in
            TickerListRow(
                firstCurrency: TickerIdentifiersStore.shared.tickerIdentifierOrCreateNew(id: ticker.id).firstCurrencyIdentifier,
                secondCurrency: TickerIdentifiersStore.shared.tickerIdentifierOrCreateNew(id: ticker.id).secondCurrencyIdentifier,
                value: PrettyValueFormatter.makePrettyString(value: ticker.rate, scale: ticker.secondCurrency?.scale, currency: nil))
        }
        .environment(\.defaultMinListRowHeight, WidgetConstant.cellHeight)
    }
    
}

#if DEBUG
struct WidgetView_Previews: PreviewProvider {
    
    static var previews: some View {
        WidgetView()
    }
    
}
#endif
