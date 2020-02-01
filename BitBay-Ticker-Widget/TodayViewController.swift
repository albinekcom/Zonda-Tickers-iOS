import NotificationCenter
import SwiftUI

final class TodayViewController: UIViewController {
    
    private let widgetUserData: WidgetUserData = WidgetUserData()
    
    @IBSegueAction private func addSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        let widgetView = WidgetView().environmentObject(widgetUserData)
        
        return UIHostingController(coder: coder, rootView: widgetView)
    }
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        widgetUserData.todayViewController = self
        widgetUserData.loadTickers()
        
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
}

extension TodayViewController: NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        widgetUserData.refreshTickers() { (error) in
            completionHandler((error == nil) ? .newData : .failed)
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let height = CGFloat(widgetUserData.tickers.count) * WidgetConfiguration.cellHeight
        
        preferredContentSize = activeDisplayMode == .expanded ? CGSize(width: maxSize.width, height: height) : maxSize
    }
    
}
