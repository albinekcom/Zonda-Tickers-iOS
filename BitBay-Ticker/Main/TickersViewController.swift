import RxCocoa
import RxSwift
import UIKit

final class TickersViewController: UIViewController {
    
    @IBOutlet private weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var editBarButtonItem: UIBarButtonItem! {
        didSet {
            editBarButtonItem
                .rx
                .tap
                .subscribe(
                    onNext: { [weak self] (_) in
//                        self?.refresh()
                        print("Tapped")
                    }
                )
                .disposed(by: disposeBag)
        }
    }
    @IBOutlet private weak var tickersTableView: UITableView! {
        didSet {
            tickersTableView.tableFooterView = UIView()
        }
    }
    
    private let disposeBag = DisposeBag()
    
    private let tickersNamesToRefresh: [Ticker.Name] = [
        .btcpln, .ethpln, .ltcpln, .lskpln,
        .btceur, .etheur, .ltceur, .lskeur,
        .btcusd, .ethusd, .ltcusd, .lskusd,
        .ltcbtc, .ethbtc, .lskbtc
    ]
    
    private var tickers = Variable<[Ticker]>([])
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTickers()
        setupNavigation()
        setupRefreshControl()
        
        refreshAtStartup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPathForSelectedRow = tickersTableView.indexPathForSelectedRow {
            tickersTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    // MARK: - Setting
    
    private func setupNavigation() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "NavigationLogo"))
        navigationController?.navigationBar.tintColor = UIColor(red: 20/255.0, green: 140/255.0, blue: 190/255.0, alpha: 1.0)
    }
    
    private func setupTickers() {
        tickers
            .asObservable()
            .map { (tickers) -> [TickerViewModel] in
                return tickers.map { ticker in
                    return TickerViewModel(model: ticker)
                }
            }
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
    
    // MARK: - Refreshing
    
    private func refreshAtStartup() {
        guard let refreshControl = tickersTableView.refreshControl else { return }
        
        tickersTableView.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.height)
        
        refreshControl.beginRefreshing()
        refresh()
    }
    
    private func refresh() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        tickersTableView.isUserInteractionEnabled = false
        
        Observable
            .zip(
                tickersNamesToRefresh.map { (tickerName) in
                    return TickerFactory.makeObservableTicker(named: tickerName)
                }
            )
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] (tickers) in
                    self?.tickers.value = tickers
                },
                onDisposed: { [weak self] in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self?.tickersTableView.isUserInteractionEnabled = true
                    
                    self?.tickersTableView.refreshControl?.endRefreshing()
                }
            )
            .disposed(by: disposeBag)
    }
    
    // MARK: - Navigating
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tickersTableView.indexPathForSelectedRow else { return }
        
        if let tickerDetailsViewController = segue.destination as? TickerDetailsViewController {
            let selectedTicker = tickers.value[selectedIndexPath.row]
            tickerDetailsViewController.viewModel = TickerDetailsViewModel(model: selectedTicker)
        }
    }
    
}
