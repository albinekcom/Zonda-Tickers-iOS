import Combine
import SwiftUI

final class ListViewModel: ObservableObject {
    
    @Published private(set) var tickerRowViewModels: [TickerRowViewModel]?
    
    @Published var isEditingPossible = false
    @Published var editMode: EditMode = .inactive
    
    @Published private(set) var errorText: String?
    
    private let dataRepository: DataRepository
    private let rowTapAction: ((String) -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataRepository: DataRepository, rowTapAction: ((String) -> Void)?) {
        self.dataRepository = dataRepository
        self.rowTapAction = rowTapAction
        
        dataRepository.$userTickerIds.combineLatest(dataRepository.$tickers)
            .map { userTickerIds, tickers in
                guard tickers.isEmpty == false else { return nil }
                
                return userTickerIds
                    .compactMap { tickers[$0] }
                    .map { TickerRowViewModel(ticker: $0) }
            }
            .assign(to: &$tickerRowViewModels)
        
        dataRepository.$state
            .sink { [weak self] in
                switch $0 {
                case .initializing, .fetching, .fetchedSuccessfully:
                    self?.errorText = nil
                    
                case let .fetchingFailed(error: error):
                    self?.errorText = error.localizedDescription
                }
            }
            .store(in: &cancellables)
        
        dataRepository.$state
            .map {
                if case let .fetchingFailed(error) = $0 {
                    return error.localizedDescription
                } else {
                    return nil
                }
            }
            .assign(to: &$errorText)
        
        $tickerRowViewModels
            .map { $0?.count != 0 }
            .assign(to: &$isEditingPossible)
    }
    
    func tapRow(tickerId: String) {
        rowTapAction?(tickerId)
    }
    
    func remove(offsets: IndexSet) {
        if let deletedUserTickerId = offsets.map({ dataRepository.userTickerIds[$0] }).first {
            AnalyticsService.shared.trackUserTickerDeleted(tickerId: deletedUserTickerId)
        }
        
        dataRepository.userTickerIds.remove(atOffsets: offsets)
    }
    
    func move(source: IndexSet, destination: Int) {
        dataRepository.userTickerIds.move(fromOffsets: source, toOffset: destination)
    }
    
}
