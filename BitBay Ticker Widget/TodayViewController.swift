import NotificationCenter
import RxCocoa
import RxSwift
import UIKit

final class TodayViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: - Setting
    
    private func setupTableView() {
        let data = Observable<[(String, String)]>.just([("first element", "Detail 1"), ("second element", "Detail 2"), ("third element", "Detail 3")])
        
        data.bind(to: tableView.rx.items(cellIdentifier: "Widget Cell")) { (index, model, cell) in
            cell.textLabel?.text = model.0
            cell.detailTextLabel?.text = model.1
        }
        .disposed(by: disposeBag)
    }
    
}

extension TodayViewController: NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
