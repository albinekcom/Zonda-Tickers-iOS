import SwiftUI

struct ListView: View {
    
    @EnvironmentObject private var modelData: ModelData
    @EnvironmentObject private var appEnvironment: AppEnvironment
    
    @State private var isShowingAdder = false
    @StateObject private var automaticMethodInvoker = AutomaticMethodInvoker()
    
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
                    .accessibilityLabel("Add Ticker")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        ProgressView()
                            .opacity(modelData.userTickers.isEmpty == false && modelData.isRefreshing ? 1 : 0)
                            .animation(.linear(duration: 0.3), value: modelData.isRefreshing)
                        EditButton()
                            .opacity(modelData.userTickers.isEmpty ? 0 : 1)
                            .accessibilityLabel("Edit Tickers")
                    }
                }
            }
            .onAppear {
                modelData.analyticsService = appEnvironment.analyticsService
                
                appEnvironment.analyticsService.trackView(tickerId: nil)
                
                let reviewController = ReviewController(analyticsService: appEnvironment.analyticsService)
                reviewController.isEnabled = !AppArguments().isUITest
                reviewController.tryToDisplay()
                
                automaticMethodInvoker.invokeMethod = { await modelData.refreshTickers() }
                automaticMethodInvoker.start()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if modelData.userTickers.isEmpty {
            Text("Press + to add a Ticker")
                .padding(.vertical)
                .padding(.horizontal, 8)
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
                        TickerRow(ticker: ticker)
                            .padding(.vertical, 8)
                    }
                }
                .onMove(perform: modelData.moveUserTicker)
                .onDelete(perform: modelData.removeUserTicker)
            }
        }
        .listStyle(.insetGrouped)
        .animation(.default, value: modelData.userTickers)
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
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Error")
            .accessibilityValue(error.localizedDescription)
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

#if DEBUG && !TESTING

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        ListView()
    }
    
}

#endif
