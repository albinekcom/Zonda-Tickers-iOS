import NotificationCenter
import SwiftUI
import UIKit

struct WidgetConstant {
    
    static let cellHeight: CGFloat = 64
}

final class TodayViewController: UIViewController {
    
    @IBSegueAction private func addSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: WidgetView().environmentObject(WidgetUserData.shared))
    }
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
}

extension TodayViewController: NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let height = CGFloat(WidgetUserData.shared.tickers.count) * WidgetConstant.cellHeight
        
        preferredContentSize = activeDisplayMode == .expanded ? CGSize(width: maxSize.width, height: height) : maxSize
    }
    
}

final class WidgetUserData: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    
    static let shared: WidgetUserData = WidgetUserData()
    
    init() {
        let t1 = Ticker(id: "BTC-PLN", rate: 111.11)
        let t2 = Ticker(id: "ETH-USD", rate: 222.22)
        let t3 = Ticker(id: "XRP-GBP", rate: 333.33)
        let t4 = Ticker(id: "XMR-EUR", rate: 444.44)
        
        tickers = [t1, t2, t3, t4]
    }
    
}

