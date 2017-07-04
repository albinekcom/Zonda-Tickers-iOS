import RxDataSources
import RxCocoa
import RxSwift
import UIKit

final class AddTickerViewController: UIViewController {
    
    @IBOutlet private weak var cancelBarButtonItem: UIBarButtonItem! {
        didSet {
            cancelBarButtonItem
                .rx
                .tap
                .subscribe(
                    onNext: { [weak self] in
                        self?.dismiss(animated: true)
                    }
                )
                .disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var addTickerTableView: UITableView! {
        didSet {
            addTickerTableView.tableFooterView = UIView()
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var tickerStore: TickerStore?
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupAddTickerTableView()
    }
    
    // MARK: - Setting
    
    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .primary
    }
    
    private func setupAddTickerTableView() {
        guard let tickerStore = tickerStore else { return }
        
        Observable<[Ticker.Name]>
            .of(tickerStore.availableTickersNamesToAdd)
            .map { (names) in
                return names.map { (name) in
                    return AddTickerViewModel(tickerName: name)
                }
            }
            .bind(to: addTickerTableView.rx.items(cellIdentifier: "AddTickerTableViewCell")) { (_, model, cell) in
                cell.textLabel?.text = model.name
            }
            .disposed(by: disposeBag)
        
        addTickerTableView
            .rx
            .itemSelected
            .subscribe(
                onNext: { [weak self] (indexPath) in
                    let tickerName = tickerStore.availableTickersNamesToAdd[indexPath.row]
                    
                    tickerStore.addTicker(named: tickerName)
                    
                    self?.dismiss(animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
    
}
