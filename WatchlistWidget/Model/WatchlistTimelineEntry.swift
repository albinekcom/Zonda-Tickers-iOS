import WidgetKit

struct WatchlistTimelineEntry: TimelineEntry {
    
    let date = Date.now
    let tickers: [Ticker]?
    
    init(tickers: [Ticker]?) {
        self.tickers = tickers
    }

}
