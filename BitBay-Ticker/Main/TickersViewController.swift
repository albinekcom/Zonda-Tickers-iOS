import RxCocoa
import RxSwift

final class TickersViewController: UIViewController {
    
    @IBOutlet private weak var tickersTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    private let tickersNamesToRefresh: [Ticker.Name] = [.btcpln, .ethpln, .ltcpln, .lskpln]
    
    private var viewModels = Variable<[TickerViewModel]>([])
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModels()
        setupRefreshControl()
        
        tickersTableView.tableFooterView = UIView()
        refresh()
    }
    
    private func setupViewModels() {
        viewModels
            .asObservable()
            .bind(to: tickersTableView.rx.items(cellIdentifier: "TickerTableViewCell", cellType: UITableViewCell.self)) { (_, viewModel, cell) in
                cell.textLabel?.text = viewModel.name
                cell.detailTextLabel?.text = viewModel.last
            }
            .disposed(by: disposeBag)
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .subscribe(
                onNext: { [weak self] (_) in
                    self?.refresh()
                }
            )
            .disposed(by: disposeBag)
        
        tickersTableView.refreshControl = refreshControl
    }
    
    private func refresh() {
        Observable
            .zip(
                tickersNamesToRefresh.map { (tickerName) in
                    return TickerFactory.makeObservableTicker(named: tickerName)
                }
            )
            .map { (tickers) -> [TickerViewModel] in
                return tickers.map { ticker in
                    return TickerViewModel(model: ticker)
                }
            }
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] (elements) in
                    self?.viewModels.value = elements
                },
                onDisposed: { [weak self] in
                    self?.tickersTableView.refreshControl?.endRefreshing()
                }
            )
            .disposed(by: disposeBag)
    }
    
}
