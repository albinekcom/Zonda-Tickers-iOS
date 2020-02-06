import NotificationCenter

final class TodayViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let widgetUserData: WidgetUserData = WidgetUserData()
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
}

extension TodayViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        widgetUserData.tickers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let widgetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WidgetTableViewCell", for: indexPath) as? WidgetTableViewCell else {
            return UITableViewCell()
        }
        
        let ticker = widgetUserData.tickers[indexPath.row]
        
        widgetTableViewCell.firstCurrency = TickerIdentifiersStore.shared.tickerIdentifierOrCreateNew(id: ticker.id).firstCurrencyIdentifier
        widgetTableViewCell.secondCurrency = TickerIdentifiersStore.shared.tickerIdentifierOrCreateNew(id: ticker.id).secondCurrencyIdentifier
        widgetTableViewCell.value = PrettyValueFormatter.makePrettyString(value: ticker.rate, scale: ticker.secondCurrency?.scale, currency: nil)
        
        return widgetTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let applicationURL = WidgetConfiguration.applicationURL else { return }
        
        extensionContext?.open(applicationURL)
    }
    
}

extension TodayViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        WidgetConfiguration.cellHeight
    }
    
}

extension TodayViewController: NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        widgetUserData.refreshTickers() { [weak self] (error) in
            self?.tableView.reloadData()
            
            completionHandler((error == nil) ? .newData : .failed)
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let height = CGFloat(widgetUserData.tickers.count) * WidgetConfiguration.cellHeight
        
        preferredContentSize = activeDisplayMode == .expanded ? CGSize(width: maxSize.width, height: height) : maxSize
    }
    
}
