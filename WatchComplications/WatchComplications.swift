import SwiftUI
import WidgetKit

@main
private struct WatchComplications: Widget {
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "WatchComplications",
            provider: WatchlistTimelineProvider()
        ) {
            ComplicationsEntryView(entry: $0)
        }
        .configurationDisplayName("Watchlist")
        .description("View and track performance of your tickers throughout the day.")
    }
    
}
