import SwiftUI

struct ListView: View {
    
    @EnvironmentObject private var modelData: ModelData
    @EnvironmentObject private var appEnvironment: AppEnvironment
    
    @State private var isShowingAdder = false
    
    var body: some View {
        content
            .navigationTitle("Tickers")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: { isShowingAdder.toggle() },
                        label: {
                            Image(systemName: .plus)
                        }
                    )
                    .sheet(isPresented: $isShowingAdder) {
                        AdderView()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        ProgressView()
                            .opacity(modelData.userTickers.isEmpty == false && modelData.isRefreshing ? 1 : 0)
                            .animation(.linear(duration: 0.3), value: modelData.isRefreshing)
                        EditButton()
                            .opacity(modelData.userTickers.isEmpty ? 0 : 1)
                    }
                }
            }
            .onAppear {
                appEnvironment.analyticsService.trackView(tickerId: nil)
                
                ReviewController(analyticsService: appEnvironment.analyticsService).tryToDisplay()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if modelData.userTickers.isEmpty {
            empty
        } else {
            filled
        }
    }
    
    private var filled: some View {
        List {
            Section(header: sectionHeader) {
                ForEach(modelData.userTickers) { ticker in
                    NavigationLink {
                        DetailView(tickerId: ticker.id)
                    } label: {
                        ticker.tickerRow
                            .padding(.vertical, 8)
                    }
                }
                .onMove(perform: modelData.moveUserTicker)
                .onDelete(perform: modelData.removeUserTicker)
            }
        }
        .listStyle(.insetGrouped)
        .animation(.default, value: modelData.availableTickers)
    }
    
    private var empty: some View {
        Text("Press + to add a Ticker")
            .padding(.vertical)
            .padding(.horizontal, 8)
    }
    
    @ViewBuilder
    private var sectionHeader: some View {
        if case let .refreshingFailure(error: error) = modelData.state {
            HStack {
                Image(systemName: .xmarkOctagonFill)
                Text(error.localizedDescription)
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .background(.red)
            .listRowInsets(EdgeInsets())
        }
    }
    
}

private extension ModelData {
    
    var isRefreshing: Bool {
        switch state {
        case .initializing, .refreshing:
            return true
        case .refreshingSuccess, .refreshingFailure:
            return false
        }
    }
    
}

#if DEBUG

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        ListView()
    }
    
}

#endif
