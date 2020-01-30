import SwiftUI

struct TickerAdder: View {
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject private var userData: UserData
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if userData.fetchingTickerIdentifiersError != nil { // HACK: Change it when hidden() method be improved
                    ErrorBanner(text: userData.fetchingTickerIdentifiersError?.localizedDescription ?? "Error")
                }
                
                List {
                    TextField(NSLocalizedString("Search", comment: ""), text: $searchTerm).modifier(ClearButton(text: $searchTerm))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    ForEach(userData.tickersIdentifiersAvailableToAdd.filter {
                        self.searchTerm.isEmpty ? true : $0.tagsContain(searchTerm: self.searchTerm)
                    }) { tickerIdentifier in
                        AdderRow(text: Text(tickerIdentifier.prettyTitle))
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
                    self.userData.isAdding = true
                    
                    UITableViewCell.appearance().selectionStyle = .none
                    
                    AnalyticsService.shared.trackAddTickerView()
                }
                .onDisappear {
                    self.userData.isAdding = false
                    self.userData.setupRefreshingTimer()
                }
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
