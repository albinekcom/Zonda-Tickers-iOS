import SwiftUI

struct TickerAdder: View {
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject private var userData: UserData
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationView {
            List {
                TextField(NSLocalizedString("Search", comment: ""), text: $searchTerm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                ForEach(userData.availableTickersIdentifiersToAdd.filter {
                    self.searchTerm.isEmpty ? true :
                        $0.title.localizedCaseInsensitiveContains(self.searchTerm)
                }) { tickerIdentifier in
                    AdderRow(text: Text(tickerIdentifier.title))
                        .padding()
                        .onTapGesture {
                            self.userData.appendAndRefreshTicker(from: tickerIdentifier)
                            self.userData.removeAvailableToAddTickerIdentifier(tickerIdentifier: tickerIdentifier)
                    }
                }
            }
            .navigationBarTitle(Text("Add Ticker"), displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.isPresented.toggle()
                }) {
                    Text("Close")
                        .frame(minWidth: MimiumTouchTargetSize.size, minHeight: MimiumTouchTargetSize.size)
                }
            )
            .modifier(AdaptsToSoftwareKeyboard())
            .onAppear {
                AnalyticsService.trackAddTickerView()
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
