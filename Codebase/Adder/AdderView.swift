import SwiftUI

struct AdderView: View {
    
    @ObservedObject private(set) var viewModel: AdderViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            AdderSearchBarView(searchText: $viewModel.searchString)
                .padding([.top, .horizontal])
            
            List {
                if let tickerRowViewModels = viewModel.tickerRowViewModels {
                    if tickerRowViewModels.isEmpty {
                        emptyRows
                    } else {
                        filledRows(tickerRowViewModels: tickerRowViewModels)
                    }
                } else {
                    EmptyView()
                }
            }
        }
        .onAppear { AnalyticsService.shared.trackView() }
    }
    
    private var emptyRows: some View {
        Text("No results")
            .padding(.vertical, 8)
    }
    
    private func filledRows(tickerRowViewModels: [TickerRowViewModel]) -> some View {
        ForEach(tickerRowViewModels) { tickerRowViewModel in
            Button(action: { viewModel.appendUserTickerId(tickerRowViewModel.id) }) {
                TickerRow(viewModel: tickerRowViewModel)
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
        AdderView(viewModel: .init(dataRepository: .init()))
    }
    
}

#endif
