import RxCocoa
import RxSwift
import UIKit

final class TickerDetailsViewController: UIViewController {
    
    @IBOutlet private weak var tickerDetailsTableView: UITableView!
    
    var viewModel = TickerDetailsViewModel(model: Ticker(name: .btceur, jsonDictionary: [:])) {
        didSet {
            viewModelValues.value = viewModel.values
        }
    }
    
    private var viewModelValues = Variable<[TickerDetailViewModelValue]>([])
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModels()
        setupTickersTableView()
        
        title = viewModel.name
    }
    
    // MARK: - Setting
    
    private func setupTickersTableView() {
        tickerDetailsTableView.tableFooterView = UIView()
    }
    
    private func setupViewModels() {
        viewModelValues
            .asObservable()
            .bind(to: tickerDetailsTableView.rx.items(cellIdentifier: "TickerDetailTableViewCell", cellType: UITableViewCell.self)) { (_, viewModel, cell) in
                cell.textLabel?.text = viewModel.title
                cell.detailTextLabel?.text = viewModel.value
            }
            .disposed(by: disposeBag)
    }
    
}
