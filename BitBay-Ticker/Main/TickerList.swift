import SwiftUI

struct TickerList: View {
    
    @EnvironmentObject private var userData: UserData
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        VStack {
            if userData.fetchingTickerPropertiesError != nil { // HACK: Change it when hidden() method be improved
                ErrorBanner(text: userData.fetchingTickerPropertiesError?.localizedDescription ?? "Error")
            }
            List {
                ForEach(userData.tickers) { ticker in
                    NavigationLink(
                        destination: TickerDetail(viewModel: TickerDetailViewModel(model: ticker))
                    ) {
                        TickerListRow(firstCurrency: TickerIdentifiersStore.shared.tickerIdentifierOrCreateNew(id: ticker.id).firstCurrencyIdentifier, secondCurrency: TickerIdentifiersStore.shared.tickerIdentifierOrCreateNew(id: ticker.id).secondCurrencyIdentifier, value: PrettyValueFormatter.makePrettyString(value: ticker.rate, scale: ticker.secondCurrency?.scale, currency: ticker.secondCurrency?.currency))
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
                .onAppear {
                    UITableViewCell.appearance().selectionStyle = .default
                }
            }
            .environment(\.defaultMinListRowHeight, 64)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        guard let tickerToDeleteIndex = offsets.first else { return }
        
        userData.removeTicker(at: tickerToDeleteIndex)
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        userData.tickers.move(fromOffsets: source, toOffset: destination)
    }
}

#if DEBUG
struct TickerList_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(["iPhone 11 Pro"], id: \.self) { deviceName in
            TickerList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
    
}
#endif
