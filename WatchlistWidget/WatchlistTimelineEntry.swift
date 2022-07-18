import WidgetKit

struct WatchlistTimelineEntry: TimelineEntry {
    
    let date: Date
    let family: WidgetFamily
    let tickers: [Ticker]?
    
    init(
        date: Date = .now,
        family: WidgetFamily,
        tickers: [Ticker]?
    ) {
        self.date = date
        self.family = family
        self.tickers = tickers
    }

}
