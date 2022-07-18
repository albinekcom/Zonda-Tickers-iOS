import SwiftUI

struct AdderView: View {
    
    @EnvironmentObject private var modelData: ModelData
    @EnvironmentObject private var appEnvironment: AppEnvironment
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText = ""
    
    private var searchResults: [Ticker] {
        modelData.availableTickers
            .filter { (searchText.isEmpty || $0.tags.joined(separator: " ").contains(searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())) }
    }
    
    var body: some View {
        NavigationView {
            List {
                if searchResults.isEmpty {
                    emptyRows
                } else {
                    filledRows
                }
            }
            .animation(.default, value: modelData.availableTickers)
            .searchable(text: $searchText)
            .disableAutocorrection(true)
            .navigationTitle("Add Ticker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: { dismiss() },
                        label: {
                            Image(systemName: .multiplyCircleFill)
                                .foregroundColor(.secondary)
                        }
                    )
                }
            }
            .onAppear { appEnvironment.analyticsService.trackView(tickerId: nil) }
        }
    }
    
    private var emptyRows: some View {
        Text("No results")
            .padding(.vertical)
    }
    
    private var filledRows: some View {
        ForEach(searchResults) { ticker in
            Button(action: {
                DispatchQueue.main.async {
                    modelData.appendUserTickerId(ticker.id)
                }
            }) {
                ticker.tickerRow
                    .modifier(PlusIconAppender())
                    .padding(.vertical, 8)
            }
        }
    }
}

private struct PlusIconAppender: ViewModifier {
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            Image(systemName: .plusCircleFill)
                .foregroundColor(.green)
                .padding(.leading, 8)
        }
    }
    
}

#if DEBUG

struct AdderView_Previews: PreviewProvider {
    
    static var previews: some View {
        AdderView()
    }
    
}

#endif
