import NotificationCenter
import UIKit

final class TodayViewController: UIViewController {
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension TodayViewController: NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
}
