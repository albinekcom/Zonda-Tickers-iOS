import SwiftUI
import WidgetKit

@main
private struct WatchlistWidget: Widget {
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "WatchlistWidget",
            provider: WatchlistTimelineProvider()
        ) {
            WatchlistEntryView(entry: $0)
        }
        .configurationDisplayName("Watchlist")
        .description("View and track performance of your tickers throughout the day.")
    }
    
}
