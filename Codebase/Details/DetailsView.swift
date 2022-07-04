import SwiftUI

struct DetailsView: View {
    
    @ObservedObject private(set) var viewModel: DetailsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.detailsRowViewModels) {
                DetailsRow(viewModel: $0)
                    .padding(.vertical, 12)
            }
        }
        .animation(.default, value: viewModel.detailsRowViewModels)
        .onAppear { AnalyticsService.shared.trackView(tickerId: viewModel.tickerId) }
    }
    
}

#if DEBUG

struct DetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailsView(viewModel: .init(dataRepository: .init(),
                                     tickerId: "btc-pln"))
    }
    
}

#endif
