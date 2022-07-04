import SwiftUI

struct ListView: View {
    
    @ObservedObject private(set) var viewModel: ListViewModel
    
    var body: some View {
        if let tickerRowViewModels = viewModel.tickerRowViewModels {
            if tickerRowViewModels.isEmpty {
                Text("Press + to add a ticker")
            } else {
                filledView(tickerRowViewModels: tickerRowViewModels)
            }
        } else {
            EmptyView()
        }
    }
    
    private func filledView(tickerRowViewModels: [TickerRowViewModel]) -> some View {
        List {
            Section(header: sectionHeader) {
                ForEach(tickerRowViewModels) { tickerRowViewModel in
                    TickerRow(viewModel: tickerRowViewModel)
                        .padding(.vertical, 4)
                        .onNavigation { viewModel.tapRow(tickerId: tickerRowViewModel.id) }
                }
                .onDelete(perform: { viewModel.remove(offsets: $0) } )
                .onMove(perform: { viewModel.move(source: $0, destination: $1) } )
            }
        }
        .animation(.default, value: viewModel.tickerRowViewModels)
        .environment(\.editMode, $viewModel.editMode)
        .listStyle(PlainListStyle())
        .onAppear { AnalyticsService.shared.trackView() }
    }
    
    private var sectionHeader: some View {
        Group {
            if let errorText = viewModel.errorText {
                HStack {
                    Image(systemName: .xmarkOctagonFill)
                    Text(errorText)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding()
                .background(.red)
                .listRowInsets(EdgeInsets())
            }
        }
    }
    
}

private extension View {

    func onNavigation(_ action: @escaping () -> ()) -> some View {
        let isActive = Binding(
            get: { false },
            set: { newValue in
                if newValue {
                    action()
                }
            }
        )
        
        return NavigationLink(destination: EmptyView(),
                              isActive: isActive) { self }
    }

}

#if DEBUG

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        ListView(viewModel: .init(dataRepository: .init(), rowTapAction: nil))
    }
    
}

#endif
