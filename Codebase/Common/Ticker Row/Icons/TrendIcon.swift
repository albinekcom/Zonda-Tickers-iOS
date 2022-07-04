import SwiftUI

enum TrendIconStyle {
    
    case up
    case neutral
    case down
    
}

struct TrendIcon: View {
    
    let trendIconStyle: TrendIconStyle
    
    var body: some View {
        GeometryReader { geometry in
            switch trendIconStyle {
            case .up:
                TrendTriangleIcon(variant: .up)
            case .neutral:
                RoundedRectangle(cornerRadius: geometry.size.height / 4)
            case .down:
                TrendTriangleIcon(variant: .down)
            }
        }
    }
    
}

#if DEBUG

struct TrendIcon_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TrendIcon(trendIconStyle: .up)
            TrendIcon(trendIconStyle: .neutral)
            TrendIcon(trendIconStyle: .down)
        }
        .padding()
    }
    
}

#endif
