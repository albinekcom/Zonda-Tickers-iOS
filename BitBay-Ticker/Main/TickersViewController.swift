import RxSwift
import UIKit

final class TickersViewController: UIViewController {
    
    @IBOutlet private weak var tickersTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloRx()
    }
    
    private func helloRx() {
        Observable
            .just("It should work!")
            .subscribe(
                onNext: { (element) in
                    print(element)
                }
            )
            .addDisposableTo(disposeBag)
    }
    
}
