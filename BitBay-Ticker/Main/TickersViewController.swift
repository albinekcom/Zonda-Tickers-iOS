import RxDataSources
import RxCocoa
import RxSwift
import UIKit

final class TickersViewController: UIViewController {
    
    @IBOutlet private weak var tickersTableView: UITableView! {
        didSet {
            tickersTableView.tableFooterView = UIView()
        }
    }
    
    private var isRefreshing = Variable<Bool>(false)
    private let tickerStore = TickerStore.shared
    private let disposeBag = DisposeBag()
    
    private let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    private let editBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
    private var doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupIsRefreshing()
        setupTickersTableView()
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
        navigationItem.title = ""
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "NavigationLogo"))
        navigationController?.navigationBar.tintColor = .primary
        
        setupBarButtonItems()
    }
    
    private func setupBarButtonItems() {
        addBarButtonItem
            .rx
            .tap
            .subscribe(
                onNext: { [weak self] (_) in
                    guard let strongSelf = self else { return }
                    
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    if let addTickerViewController = mainStoryboard.instantiateViewController(withIdentifier: "AddTickerViewController") as? AddTickerViewController {
                        addTickerViewController.tickerStore = strongSelf.tickerStore
                        let navigationController = UINavigationController(rootViewController: addTickerViewController)
                        
                        strongSelf.present(navigationController, animated: true)
                    }
                }
            )
            .disposed(by: disposeBag)
        
        editBarButtonItem
            .rx
            .tap
            .subscribe(
                onNext: { [weak self] (_) in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.navigationItem.leftBarButtonItem = nil
                    strongSelf.navigationItem.rightBarButtonItem = strongSelf.doneBarButtonItem
                    
                    strongSelf.tickersTableView.setEditing(!strongSelf.tickersTableView.isEditing, animated: true)
                    strongSelf.tickersTableView.refreshControl = nil
                }
            )
            .disposed(by: disposeBag)
        
        doneBarButtonItem
            .rx
            .tap
            .subscribe(
                onNext: { [weak self] (_) in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.navigationItem.leftBarButtonItem = strongSelf.addBarButtonItem
                    strongSelf.navigationItem.rightBarButtonItem = strongSelf.editBarButtonItem
                    
                    strongSelf.tickersTableView.setEditing(!strongSelf.tickersTableView.isEditing, animated: true)
                    strongSelf.setupRefreshControl()
                }
            )
            .disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem = addBarButtonItem
        navigationItem.rightBarButtonItem = editBarButtonItem
    }
    
    private func setupIsRefreshing() {
        isRefreshing
            .asObservable()
            .subscribe(
                onNext: { [weak self] (value) in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = value
                    self?.tickersTableView.isUserInteractionEnabled = !value
                    self?.navigationItem.leftBarButtonItem?.isEnabled = !value
                    self?.navigationItem.rightBarButtonItem?.isEnabled = !value
                    
                    if value {
                        self?.tickersTableView.refreshControl?.beginRefreshing()
                    } else {
                        self?.tickersTableView.refreshControl?.endRefreshing()
                    }

                }
            )
            .disposed(by: disposeBag)
    }
    
    private func setupTickersTableView() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfTickerViewModel>()
        
        dataSource.configureCell = { (_, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TickerTableViewCell", for: indexPath)
            
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = item.last
            
            return cell
        }
        
        dataSource.canEditRowAtIndexPath = { (_) in
            return true
        }
        
        dataSource.canMoveRowAtIndexPath = { (_) in
            return true
        }
        
        tickerStore.userTickers
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] (indexPath) in
                    self?.isRefreshing.value = false
                }
            )
            .disposed(by: disposeBag)
        
        tickerStore.userTickers
            .asObservable()
            .map { (tickers) in
                tickers.map { (ticker) in
                    return TickerViewModel(ticker: ticker)
                }
            }
            .map { (tickersViewModels) in
                return [SectionOfTickerViewModel(items: tickersViewModels)]
            }
            .bind(to: tickersTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tickersTableView
            .rx
            .itemDeleted
            .subscribe(
                onNext: { [weak self] (indexPath) in
                    self?.tickerStore.userTickers.value.remove(at: indexPath.row)
                }
            )
            .disposed(by: disposeBag)
        
        tickersTableView
            .rx
            .itemMoved
            .subscribe(
                onNext: { [weak self] (itemMovedEvent) in
                    guard let strongSelf = self else { return }
                    
                    let movedTicker = strongSelf.tickerStore.userTickers.value.remove(at: itemMovedEvent.sourceIndex.row)
                    strongSelf.tickerStore.userTickers.value.insert(movedTicker, at: itemMovedEvent.destinationIndex.row)
                }
            )
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
        if let refreshControl = tickersTableView.refreshControl {
            tickersTableView.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.height)
            
            refresh()
        }
    }
    
    private func refresh() {
        if tickerStore.userTickers.value.isEmpty {
            isRefreshing.value = false
        } else {
            isRefreshing.value = true
            
            tickerStore.refreshTickers()
        }
    }
    
    // MARK: - Navigating
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = tickersTableView.indexPathForSelectedRow, let tickerDetailsViewController = segue.destination as? TickerDetailsViewController {
            let selectedTicker = tickerStore.userTickers.value[selectedIndexPath.row]
            tickerDetailsViewController.viewModel = TickerDetailsViewModel(ticker: selectedTicker)
        }
    }
    
}
