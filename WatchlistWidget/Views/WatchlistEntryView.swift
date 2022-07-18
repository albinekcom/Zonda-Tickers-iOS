import SwiftUI
import WidgetKit

struct WatchlistEntryView: View {
    
    let entry: WatchlistTimelineEntry
    
    var body: some View {
        if let tickers = entry.tickers, tickers.isEmpty {
            EmptyView()
        } else if let tickers = entry.tickers {
            FilledView(
                tickers: tickers.firstElements(maximumCount: entry.family.tickersMaximumCount),
                maximumCount: entry.family.tickersMaximumCount,
                isSimpleTickerRowUsed: entry.family.isSimpleTickerRowUsed
            )
        } else {
            PlaceholderView(
                count: entry.family.tickersMaximumCount,
                isCircleVisible: entry.family.isPlaceholderCircleVisible,
                isSimpleTitle: entry.family.isSimplePlaceholderTitle
            )
        }
    }
    
    private struct EmptyView: View {
        
        var body: some View {
            Text("No Tickers")
        }
        
    }
    
}

#if DEBUG

struct WatchlistEntryView_Previews: PreviewProvider {
    
    static var previews: some View {
        watchlistEntryViewPreview(
            tickers: .filledTickersStub(count: 6),
            family: .systemSmall
        )
        watchlistEntryViewPreview(
            tickers: [],
            family: .systemSmall
        )
        watchlistEntryViewPreview(
            tickers: nil,
            family: .systemSmall
        )
    }
    
    private static func watchlistEntryViewPreview(
        tickers: [Ticker]?,
        family: WidgetFamily
    ) -> some View {
        WatchlistEntryView(entry: .init(
            family: family,
            tickers: tickers
        ))
        .previewContext(WidgetPreviewContext(family: family))
    }
    
}

private extension Array where Element == Ticker {
    
    static func filledTickersStub(count: Int = 42) -> Self {
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
        rate: 123456789.45,
        average: 123.00
    )
    
}

#endif
