import SwiftUI
import WidgetKit

struct WatchlistEntryView: View {
    
    let entry: WatchlistTimelineEntry
    
    @Environment(\.widgetFamily) private var widgetFamily
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
            SystemView(
                tickers: entry.tickers,
                tickersMaximumCount: widgetFamily.tickersMaximumCount,
                isSystemSmall: widgetFamily == .systemSmall
            )
            
        case .accessoryInline:
            AccessoryInlineView(tickers: entry.tickers)
            
        case .accessoryCircular:
            AccessoryCircularView(tickers: entry.tickers)
            
        case .accessoryRectangular:
            AccessoryRectangularView(
                tickers: entry.tickers,
                tickersMaximumCount: widgetFamily.tickersMaximumCount
            )
            
        @unknown default:
            EmptyView()
        }
    }
    
}

#if DEBUG && !TESTING

@available(iOSApplicationExtension 16.0, *)
struct WatchlistEntryView_Previews: PreviewProvider {
    
    static var previews: some View {
        watchlistEntryViewPreview(tickers: nil)
        watchlistEntryViewPreview(tickers: [])
        watchlistEntryViewPreview(tickers: [Ticker].stub())
    }
    
    private static func watchlistEntryViewPreview(
        tickers: [Ticker]?,
        family: WidgetFamily = .systemMedium
    ) -> some View {
        WatchlistEntryView(entry: .init(tickers: tickers))
            .previewContext(WidgetPreviewContext(family: family))
    }
    
}

private extension Array where Element == Ticker {
    
    static func stub(count: Int = 42) -> Self {
        (0 ..< count).map { _ in .stub }
    }
    
}

private extension Ticker {
    
    static let stub: Self = .init(
        firstCurrency: .init(
            id: "btc",
            name: "Bitcoin",
            precision: 8),
        secondCurrency: .init(
            id: "pln",
            name: "Złoty",
            precision: 2),
        rate: 200.00,
        average: 123.00
    )
    
}

#endif
