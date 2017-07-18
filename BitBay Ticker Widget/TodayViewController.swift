import NotificationCenter
import RxCocoa
import RxSwift
import UIKit

final class TodayViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    fileprivate let tickerStore = TickerStore()
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        tickerStore.loadUserData()
    }
    
    // MARK: - Setting
    
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
    }
    
}

extension TodayViewController: NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        tickerStore.refreshTickers(completion: nil)
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
