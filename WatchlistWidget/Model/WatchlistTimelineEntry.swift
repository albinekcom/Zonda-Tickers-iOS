import WidgetKit

struct WatchlistTimelineEntry: TimelineEntry {
    
    let date = Date.now
    let family: WidgetFamily
    let tickers: [Ticker]?
    
    init(
        family: WidgetFamily,
        tickers: [Ticker]?
    ) {
        self.family = family
        self.tickers = tickers
    }

}
