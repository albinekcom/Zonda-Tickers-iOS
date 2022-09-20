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
        .supportedFamilies(.supportedSystemFamilies + .supportedAccessoryFamilies)
    }
    
}

private extension Array where Element == WidgetFamily {
    
    static let supportedSystemFamilies: [WidgetFamily] = [
        .systemSmall,
        .systemMedium,
        .systemLarge
    ]
    
    static var supportedAccessoryFamilies: [WidgetFamily] {
        if #available(iOSApplicationExtension 16.0, *) {
            return [
                .accessoryInline,
                .accessoryCircular,
                .accessoryRectangular
            ]
        } else {
            return []
        }
    }
    
}
