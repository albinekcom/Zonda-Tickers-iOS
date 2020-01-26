import SwiftUI

struct TickerList: View {
    
    @EnvironmentObject private var userData: UserData
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        VStack {
            if userData.fetchingError != nil { // HACK: Change it when hidden() method be improved
                ErrorBanner(text: userData.fetchingError?.localizedDescription ?? "Error")
                    .transition(.move(edge: .top))
            }
            List {
                ForEach(userData.tickers) { ticker in
                    NavigationLink(
                        destination: TickerDetail(viewModel: TickerDetailViewModel(model: ticker))
                    ) {
                        BasicRow(title: Text(TickerIdentifiersStore.shared.tickerIdentifierOrCreateNew(id: ticker.id).prettyTitle), value: PrettyValueFormatter.makePrettyString(value: ticker.rate, scale: ticker.secondCurrency?.scale, currency: ticker.secondCurrency?.currency))
                            .padding(.top)
                            .padding(.bottom)
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
                .onAppear {
                    UITableViewCell.appearance().selectionStyle = .default
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        if let tickerToDeleteIndex = offsets.first {
            let tickerToDelete = userData.tickers[tickerToDeleteIndex]
            let analyticsParamaters = AnalyticsParametersFactory.makeParameters(from: tickerToDelete)
            
            AnalyticsService.shared.trackRemovedTicker(parameters: analyticsParamaters)
        }
        
        userData.tickers.remove(atOffsets: offsets)
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