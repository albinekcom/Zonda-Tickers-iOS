import WidgetKit

extension Array {
    
    func firstElements(maximumCount: Int) -> Self {
        count <= maximumCount ? self : Array(self[0..<maximumCount])
    }
    
}

extension WidgetFamily {
    
    var tickersMaximumCount: Int {
        switch self {
        case .systemSmall, .systemMedium: return 3
        case .systemLarge, .systemExtraLarge: return 6
        @unknown default: return 6
        }
    }
    
    var isSimpleTickerRowUsed: Bool {
        switch self {
        case .systemSmall: return true
        case .systemMedium, .systemLarge, .systemExtraLarge: return false
        @unknown default: return false
        }
    }
    
    var isPlaceholderCircleVisible: Bool {
        switch self {
        case .systemSmall: return false
        case .systemMedium, .systemLarge, .systemExtraLarge: return true
        @unknown default: return true
        }
    }
    
    var isSimplePlaceholderTitle: Bool {
        switch self {
        case .systemSmall: return true
        case .systemMedium, .systemLarge, .systemExtraLarge: return false
        @unknown default: return false
        }
    }
    
}
