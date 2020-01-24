import SwiftUI

struct TickerAdder: View {
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject private var userData: UserData
    @State private var searchTerm: String = ""
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        
        UITableView.appearance().allowsSelection = false
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List {
                TextField(NSLocalizedString("Search", comment: ""), text: $searchTerm).modifier(ClearButton(text: $searchTerm))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                ForEach(userData.availableTickersIdentifiersToAdd.filter {
                    self.searchTerm.isEmpty ? true :
                        $0.title.localizedCaseInsensitiveContains(self.searchTerm)
                }) { tickerIdentifier in
                    AdderRow(text: Text(tickerIdentifier.title))
                        .contentShape(Rectangle())
                        .padding()
                        .onTapGesture {
                            self.userData.appendAndRefreshTicker(from: tickerIdentifier)
                            self.userData.removeAvailableToAddTickerIdentifier(tickerIdentifier: tickerIdentifier)
                            
                            AnalyticsService.shared.trackAddedTicker(parameters: AnalyticsParametersFactory.makeParameters(from: tickerIdentifier))
                        }
                }
            }
            .navigationBarTitle(Text("Add Ticker"), displayMode: .inline)
            .modifier(AdaptsToSoftwareKeyboard())
            .onAppear {
                AnalyticsService.shared.trackAddTickerView()
            }
        }
        .accentColor(Color.applicationPrimary)
    }
}

#if DEBUG
struct TickerAdder_Previews: PreviewProvider {
    
    static var previews: some View {
        TickerAdder(isPresented: .constant(true))
    }
    
}
#endif
