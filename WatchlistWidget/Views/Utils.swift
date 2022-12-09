import WidgetKit

extension Array {
    
    func firstElements(maximumCount: Int) -> Self {
        count <= maximumCount ? self : Array(self[0..<maximumCount])
    }
    
}

extension WidgetFamily {
    
    var tickersMaximumCount: Int {
        switch self {
        case .accessoryInline, .accessoryCircular: return 1
        case .systemSmall, .systemMedium, .accessoryRectangular: return 3
        case .systemLarge, .systemExtraLarge: return 6
        @unknown default: return 1
        }
    }
    
}
