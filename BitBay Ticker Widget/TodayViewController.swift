import NotificationCenter
import RxCocoa
import RxSwift
import UIKit

final class TodayViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    fileprivate let tickerStore = TickerStore.shared
    
    fileprivate let cellHeight = CGFloat(44)
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        setupTableView()
        setupRefreshingTickerStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tickerStore.loadUserData()
    }
    
    // MARK: - Setting
    
    private func setupRefreshingTickerStore() {
        tickerStore.refreshingSubject
            .subscribe(
                onNext: { [weak self] (_) in
                    self?.tickerStore.saveUserData()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tickerStore.userTickers
            .asObservable()
            .map { (tickers) in
                tickers.map { (ticker) in
                    return TickerViewModel(ticker: ticker)
                }
            }
            .bind(to: tableView.rx.items(cellIdentifier: "Widget Cell")) { (index, model, cell) in
                guard let tickerTableViewCell = cell as? TickerTableViewCell else { return }
                
                tickerTableViewCell.titleLabel.text = model.name
                tickerTableViewCell.subtitleLabel.text = model.last
                tickerTableViewCell.trendView.value = model.differenceRatioInPercantage
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .itemSelected
            .subscribe(
                onNext: { [weak self] (_) in
                    self?.launchApplication()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func launchApplication() {
        guard let applicationURL = URL(string: "BitBay-Ticker://") else { return }
        
        extensionContext?.open(applicationURL)
    }
    
}

extension TodayViewController: NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        tickerStore.loadUserData()
        tickerStore.refreshTickers(refreshingType: .widget) { (error) in
            completionHandler((error == nil) ? .newData : .failed)
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        tickerStore.loadUserData()
        
        let height = CGFloat(tickerStore.userTickers.value.count) * cellHeight
        
        preferredContentSize = activeDisplayMode == .expanded ? CGSize(width: maxSize.width, height: height) : maxSize
    }
    
}
