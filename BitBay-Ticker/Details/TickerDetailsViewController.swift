import RxCocoa
import RxSwift
import UIKit

final class TickerDetailsViewController: UIViewController {
    
    @IBOutlet private weak var tickerDetailsTableView: UITableView! {
        didSet {
            tickerDetailsTableView.tableFooterView = UIView()
        }
    }
    
    var viewModel: TickerDetailsViewModel? {
        didSet {
            if let viewModel = viewModel {
                viewModelValues.value = viewModel.values
            }
        }
    }
    
    private var viewModelValues = Variable<[TickerDetailViewModelValue]>([])
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupViewModels()
        
        title = viewModel?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let ticker = viewModel?.ticker {
            let analyticsParameters = AnalyticsParametersFactory.makeParameters(from: ticker)
            AnalyticsService.trackTickerDetailsView(parameters: analyticsParameters)
        }
    }
    
    // MARK: - Setting
    
    private func setupNavigation() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
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
