import StoreKit
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
    private var disposeBagForTableView: DisposeBag!
    
    private var copiedUserTickers = [Ticker]()
    
    private let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    private let editBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
    private var doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    
    private let reviewController = ReviewController(userDefaults: UserDefaults(suiteName: TickerStore.sharedDefaultsIdentifier))
    
    private var timer: Timer?
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupIsRefreshing()
        setupNavigation()
        setupRefreshControl()
        
        setupTickersTableView()
        setupRefreshingTickersTableView()
        setupUserTickers()
        
        refreshAtStartup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPathForSelectedRow = tickersTableView.indexPathForSelectedRow {
            tickersTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
        
        scheduleAutoRefreshingTimer()
        
        AnalyticsService.trackTickersView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeAutoRefreshingTimer()
    }
    
    // MARK: - Setting
    
    private func setupUserTickers() {
        tickerStore.userTickers
            .asObservable()
            .subscribe(
                onNext: { [weak self] (_) in
                    self?.tickerStore.saveUserData()
                }
            )
            .disposed(by: disposeBag)
    }
    
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
                    
                    if strongSelf.tickersTableView.isEditing {
                        AnalyticsService.trackEditTickersView()
                    }
                    
                    strongSelf.removeAutoRefreshingTimer()
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
                    
                    strongSelf.scheduleAutoRefreshingTimer()
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
    
    private func setupRefreshingTickersTableView() {
        tickerStore.refreshingSubject
            .subscribe(
                onNext: { [weak self] (_) in
                    self?.setupTickersTableView()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func setupTickersTableView() {
        copiedUserTickers = tickerStore.userTickers.value
        
        disposeBagForTableView = DisposeBag()
        
        let animatedDataSource = RxTableViewSectionedAnimatedDataSource<SectionOfTickerViewModel>()
        
        animatedDataSource.animationConfiguration = AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left)
        
        animatedDataSource.configureCell = { (_, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TickerTableViewCell", for: indexPath)
            
            if let tickerTableViewCell = cell as? TickerTableViewCell {
                tickerTableViewCell.titleLabel.text = item.name
                tickerTableViewCell.subtitleLabel.text = item.last
                tickerTableViewCell.trendView.value = item.differenceRatioInPercantage
            }
            
            return cell
        }
        
        animatedDataSource.canEditRowAtIndexPath = { _ in
            return true
        }
        
        animatedDataSource.canMoveRowAtIndexPath = { _ in
            return true
        }
        
        let vieModels = copiedUserTickers.map {
            return TickerViewModel(ticker: $0)
        }
        
        let sections = [SectionOfTickerViewModel(items: vieModels)]
        
        let initialState = SectionedTableViewState(sections: sections)
        
        let deleteCommand = tickersTableView.rx.itemDeleted.asObservable().map(TableViewEditingCommand.DeleteItem)
        
        let movedCommand = tickersTableView.rx.itemMoved.map(TableViewEditingCommand.MoveItem)
        
        Observable.of(deleteCommand, movedCommand)
            .merge()
            .scan(initialState) { (state: SectionedTableViewState, command: TableViewEditingCommand) -> SectionedTableViewState in
                return state.execute(command: command)
            }
            .startWith(initialState)
            .map {
                $0.sections
            }
            .shareReplay(1)
            .bind(to: tickersTableView.rx.items(dataSource: animatedDataSource))
            .addDisposableTo(disposeBagForTableView)
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .subscribe(
                onNext: { [weak self] (_) in
                    self?.refresh(refreshingType: .user)
                }
            )
            .disposed(by: disposeBag)
        
        tickersTableView.refreshControl = refreshControl
        
        tickerStore.lastUpdateDate
            .asObservable()
            .subscribe(
                onNext: { [weak self] (lastDate) in
                    guard let lastDate = lastDate else { return }
                    
                    let lastUpdateText = TextFactory.makeLastUpdateDateText(updateDate: lastDate)
                    self?.tickersTableView.refreshControl?.attributedTitle = NSAttributedString(string: lastUpdateText, attributes: [NSForegroundColorAttributeName: UIColor.refreshControl])
                }
            )
            .disposed(by: disposeBag)
    }
    
    // MARK: - Refreshing
    
    private func refreshAtStartup() {
        if let refreshControl = tickersTableView.refreshControl {
            tickersTableView.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.height)
            
            refresh(refreshingType: .automatic)
        }
    }
    
    private func refresh(refreshingType: TickerStore.RefreshingType) {
        removeAutoRefreshingTimer()
        
        if copiedUserTickers.isEmpty {
            isRefreshing.value = false
            
            return
        }
        
        isRefreshing.value = true
        
        tickerStore.refreshTickers(refreshingType: refreshingType) { [weak self] (error) in
            if let error = error {
                let alertController = UIAlertController(title: NSLocalizedString("error", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel)
                alertController.addAction(cancelAction)
                
                self?.present(alertController, animated: true) { [weak self] in
                    self?.isRefreshing.value = false
                }
                
                self?.removeAutoRefreshingTimer()
            } else {
                self?.isRefreshing.value = false
                self?.tickerStore.lastUpdateDate.value = Date(timeIntervalSinceNow: 0)
                
                if refreshingType == .user {
                    self?.reviewController.incrementSuccessfulRefreshCount()
                    
                    if self?.reviewController.shouldDisplayReviewController == true {
                        self?.reviewController.clearSuccessfulRefreshCount()
                        self?.reviewController.displayReviewController()
                    }
                }
                
                self?.scheduleAutoRefreshingTimer()
            }
        }
    }
    
    // MARK: - Navigating
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = tickersTableView.indexPathForSelectedRow, let tickerDetailsViewController = segue.destination as? TickerDetailsViewController {
            let selectedTicker = copiedUserTickers[selectedIndexPath.row]
            tickerDetailsViewController.viewModel = TickerDetailsViewModel(ticker: selectedTicker)
        }
    }
    
    // MARK: - Autorefreshing
    
    func scheduleAutoRefreshingTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(automaticRefresh), userInfo: nil, repeats: true)
    }
    
    func removeAutoRefreshingTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func automaticRefresh() {
        refresh(refreshingType: .automatic)
    }
    
}
