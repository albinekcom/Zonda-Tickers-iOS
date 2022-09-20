import SwiftUI
import WidgetKit

struct WatchlistEntryView: View {
    
    let entry: WatchlistTimelineEntry
    
    var body: some View {
        switch entry.family {
        case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
            SystemView(
                tickers: entry.tickers,
                maximumCount: entry.family.tickersMaximumCount,
                isSystemSmall: entry.family.isSystemSmall
            )
            
        case .accessoryInline:
            AccessoryInlineView(tickers: entry.tickers)
            
        case .accessoryCircular:
            AccessoryCircularView(tickers: entry.tickers)
            
        case .accessoryRectangular:
            AccessoryRectangularView(
                tickers: entry.tickers,
                maximumCount: entry.family.tickersMaximumCount
            )
            
        @unknown default:
            EmptyView()
        }
    }
    
}

#if DEBUG && !TESTING

struct WatchlistEntryView_Previews: PreviewProvider {
    
    static var previews: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            watchlistEntryViewPreview(
                family: .accessoryCircular,
                tickers: nil
            )
            watchlistEntryViewPreview(
                family: .accessoryCircular,
                tickers: []
            )
            watchlistEntryViewPreview(
                family: .accessoryCircular,
                tickers: [Ticker].stub()
            )
        } else {
            EmptyView()
        }
    }
    
    private static func watchlistEntryViewPreview(
        family: WidgetFamily,
        tickers: [Ticker]?
    ) -> some View {
        WatchlistEntryView(entry: .init(
            family: family,
            tickers: tickers
        ))
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
