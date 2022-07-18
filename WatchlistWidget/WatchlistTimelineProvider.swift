import WidgetKit

struct WatchlistTimelineProvider: TimelineProvider {
    
    private let refreshIntervalInMinutes = 15
    
    private let modelData = ModelData()
    
    func placeholder(in context: Context) -> WatchlistTimelineEntry {
        .init(
            family: context.family,
            tickers: nil
        )
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (WatchlistTimelineEntry) -> ()
    ) {
        Task {
            completion(.init(
                family: context.family,
                tickers: await modelData.fetchUserTickers()
            ))
        }
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<WatchlistTimelineEntry>) -> ()
    ) {
        Task {
            completion(.init(
                entries: [.init(
                    family: context.family,
                    tickers: await modelData.fetchUserTickers()
                )],
                policy: .after(Calendar.current.date(
                    byAdding: .minute,
                    value: refreshIntervalInMinutes,
                    to: .now
                )!)
            ))
        }
    }
    
}
