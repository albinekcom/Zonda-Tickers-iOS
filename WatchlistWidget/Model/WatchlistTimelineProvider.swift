import WidgetKit

struct WatchlistTimelineProvider: TimelineProvider {
    
    private let userTickerService = UserTickerService()
    
    func placeholder(in context: Context) -> WatchlistTimelineEntry {
        context.watchlistTimelineEntry(tickers: nil)
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (WatchlistTimelineEntry) -> ()
    ) {
        Task {
            completion(context.watchlistTimelineEntry(tickers: await userTickerService.userTickers))
        }
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<WatchlistTimelineEntry>) -> ()
    ) {
        Task {
            completion(.init(
                entries: [context.watchlistTimelineEntry(tickers: await userTickerService.userTickers)],
                policy: .refreshInterval())
            )
        }
    }
    
}

private extension TimelineReloadPolicy {
    
    static func refreshInterval(minutes: Int = 15) -> TimelineReloadPolicy {
        .after(Calendar.current.date(
            byAdding: .minute,
            value: minutes,
            to: .now
        )!)
    }
    
}

private extension TimelineProviderContext {
    
    func watchlistTimelineEntry(tickers: [Ticker]?) -> WatchlistTimelineEntry {
        .init(
            family: family,
            tickers: tickers
        )
    }
    
}
