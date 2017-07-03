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
    
    private weak var addTickerTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    var tickerStore = TickerStore()
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupAddTickerTableView()
    }
    
    // MARK: - Setting
    
    private func setupAddTickerTableView() {
        let data = Observable<[String]>.just(["first element", "second element", "third element"])
        
        data
            .bind(to: addTickerTableView.rx.items(cellIdentifier: "AddTickerTableViewCell")) { (_, model, cell) in
                cell.textLabel?.text = model
            }
            .disposed(by: disposeBag)
        
        addTickerTableView
            .rx
            .itemSelected
            .subscribe(
                onNext: { (indexPath) in
                    print("Selected \(indexPath)")
                }
            )
            .disposed(by: disposeBag)
    }
    
}
