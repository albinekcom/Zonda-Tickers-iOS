import SwiftUI

struct TickerAdderContent: View {
    
    @EnvironmentObject private var userData: UserData
    @State private var searchTerm: String = ""
    
    var body: some View {
        VStack {
            if userData.fetchingTickerIdentifiersError != nil { // HACK: Change it when hidden() method be improved
                ErrorBanner(text: userData.fetchingTickerIdentifiersError?.localizedDescription ?? "Error")
            }
            
            List {
                TextField(NSLocalizedString("Search", comment: ""), text: $searchTerm).modifier(ClearButton(text: $searchTerm))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                if (self.userData.tickersIdentifiersAvailableToAdd.filter { searchTerm.isEmpty ? true : $0.tagsContain(searchTerm: searchTerm) }).isEmpty { // TODO: Improve this line of code because it is repetitive
                    TickerAdderEmpty()
                } else { // TODO: Move code in else to another component
                    ForEach(self.userData.tickersIdentifiersAvailableToAdd.filter {
                        searchTerm.isEmpty ? true : $0.tagsContain(searchTerm: searchTerm) // TODO: Improve this line of code because it is repetitive
                    }) { tickerIdentifier in
                        AdderRow(firstCurrency: tickerIdentifier.firstCurrencyIdentifier, secondCurrency: tickerIdentifier.secondCurrencyIdentifier)
                            .contentShape(Rectangle())
                            .padding(.horizontal, 4)
                            .onTapGesture {
                                self.userData.appendAndRefreshTicker(from: tickerIdentifier)
                                self.userData.removeAvailableToAddTickerIdentifier(tickerIdentifier: tickerIdentifier)
                                
                                AnalyticsService.shared.trackAddedTicker(parameters: AnalyticsParametersFactory.makeParameters(from: tickerIdentifier))
                            }
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 64)
        }
    }
    
}

#if DEBUG
struct TickerAdderContent_Previews: PreviewProvider {
    
    static var previews: some View {
        TickerAdderContent()
    }
    
}
#endif
