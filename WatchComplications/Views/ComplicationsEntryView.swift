import SwiftUI
import WidgetKit

struct ComplicationsEntryView: View {
    
    let entry: WatchlistTimelineEntry

    var body: some View {
        switch entry.family {
        case .accessoryRectangular:
            AccessoryRectangularView(
                tickers: entry.tickers,
                maximumCount: entry.family.tickersMaximumCount
            )
            
        case .accessoryCircular:
            AccessoryCircularView(tickers: entry.tickers)
            
        case .accessoryCorner:
            AccessoryCornerView(tickers: entry.tickers)
            
        case .accessoryInline:
            AccessoryInlineView(tickers: entry.tickers)
            
        @unknown default:
            EmptyView()
        }
    }
    
}

#if DEBUG && !TESTING

struct ComplicationsEntryView_Previews: PreviewProvider {
    
    static var previews: some View {
        complicationsEntryViewPreview(
            family: .accessoryInline,
            tickers: nil
        )
        complicationsEntryViewPreview(
            family: .accessoryInline,
            tickers: []
        )
        complicationsEntryViewPreview(
            family: .accessoryInline,
            tickers: [Ticker].stub()
        )
    }
    
    private static func complicationsEntryViewPreview(
        family: WidgetFamily,
        tickers: [Ticker]?
    ) -> some View {
        ComplicationsEntryView(entry: .init(
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
