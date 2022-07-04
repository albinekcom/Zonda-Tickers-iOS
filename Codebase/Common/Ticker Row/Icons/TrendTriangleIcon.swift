import SwiftUI

struct TrendTriangleIcon: View {
    
    enum Variant {
        
        case up
        case down
        
    }
    
    let variant: Variant
    
    private let radiusRatio: CGFloat = 0.16
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            Path { path in
                let radius = min(width, height) * radiusRatio
                let radiusHalf = radius / 2
                
                let bottomLeftPoint = CGPoint(x: -radiusHalf,
                                              y: height - radiusHalf)
                let topPoint = CGPoint(x: width / 2,
                                       y: -radiusHalf)
                let bottomRightPoint = CGPoint(x: width + radiusHalf,
                                               y: height - radiusHalf)
                
                let midPoint = CGPoint(x: (bottomLeftPoint.x + topPoint.x) / 2,
                                       y: (bottomLeftPoint.y + topPoint.y) / 2)
                
                path.move(to: midPoint)
                path.addArc(tangent1End: topPoint,
                            tangent2End: bottomRightPoint,
                            radius: radius)
                path.addArc(tangent1End: bottomRightPoint,
                            tangent2End: bottomLeftPoint,
                            radius: radius)
                path.addArc(tangent1End: bottomLeftPoint,
                            tangent2End: topPoint,
                            radius: radius)
            }
        }
        .rotationEffect(.radians(variant == .up ? 0 : .pi))
    }
    
}

#if DEBUG

struct TrendTriangleIcon_Previews: PreviewProvider {
    
    static var previews: some View {
        TrendTriangleIcon(variant: .up)
        TrendTriangleIcon(variant: .down)
    }
    
}

#endif
