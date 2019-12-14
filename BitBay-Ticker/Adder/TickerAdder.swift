import SwiftUI

struct TickerAdder: View {
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject private var userData: UserData
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationView {
            KeyboardHost {
                List {
                    TextField(NSLocalizedString("add.ticker.search.placeholder", comment: ""), text: $searchTerm)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    ForEach(userData.availableTickersIdentifiersToAdd.filter {
                        self.searchTerm.isEmpty ? true :
                            $0.title.localizedCaseInsensitiveContains(self.searchTerm)
                    }) { tickerIdentifier in
                        AdderRow(text: tickerIdentifier.title)
                            .padding(.top)
                            .padding(.bottom)
                            .onTapGesture {
                                self.userData.appendTicker(from: tickerIdentifier)
                                self.userData.removeAvailableToAddTickerIdentifier(tickerIdentifier: tickerIdentifier)
                            }
                    }
                }
                .navigationBarTitle(Text("add.ticker.title"), displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        self.isPresented.toggle()
                    }) {
                        Text("Done") // TODO: Use system button or add Localizable key here
                    }
                )
            }
        }
    }
}

#if DEBUG
struct TickerAdder_Previews: PreviewProvider {
    
    static var previews: some View {
        TickerAdder(isPresented: .constant(true))
    }
    
}
#endif
