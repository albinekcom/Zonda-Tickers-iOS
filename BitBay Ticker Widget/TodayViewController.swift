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
        
        setupUserTickers()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tickerStore.loadUserData()
        tickerStore.refreshTickers(completion: nil)
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
    
    private func setupTableView() {
        tickerStore.userTickers
            .asObservable()
            .map { (tickers) in
                tickers.map { (ticker) in
                    return TickerViewModel(ticker: ticker)
                }
            }
            .bind(to: tableView.rx.items(cellIdentifier: "Widget Cell")) { (index, model, cell) in
                cell.textLabel?.text = model.name
                cell.detailTextLabel?.text = model.last
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
        tickerStore.refreshTickers { (error) in
            let updateResult: NCUpdateResult
            
            if let _ = error {
                updateResult = .failed
            } else {
                updateResult = .newData
            }
            
            completionHandler(updateResult)
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        
        let height = CGFloat(tickerStore.userTickers.value.count) * cellHeight
        
        preferredContentSize = expanded ? CGSize(width: maxSize.width, height: height) : maxSize
    }
    
}
