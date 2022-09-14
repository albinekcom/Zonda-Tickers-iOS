import SwiftUI

struct TickerRow: View {
    
    let firstCurrencyId: String
    let secondCurrencyId: String
    let rate: Double?
    let ratePrecision: Int
    let changeRatio: Double?
    
    var body: some View {
        HStack {
            titleLabel
            Spacer()
            values
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(firstCurrencyId.uppercased()) \\ \(secondCurrencyId.uppercased())")
        .accessibilityValue(Text(rate?.pretty(precision: ratePrecision) ?? "Unknown"))
    }
    
    private var titleLabel: some View {
        HStack {
            CurrencyLogo(currencyId: firstCurrencyId)
                .frame(maxWidth: 32, maxHeight: 32)
            HStack(alignment: .top, spacing: 4) {
                Text(firstCurrencyId.uppercased())
                    .font(.headline)
                Text("\\ \(secondCurrencyId.uppercased())")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .layoutPriority(1)
    }
    
    private var values: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(rate?.pretty(precision: ratePrecision) ?? "-")
                .font(.headline)
            HStack(spacing: 4) {
                TrendIcon(variant: changeRatio?.trendIconVariant ?? .neutral)
                    .frame(width: 12, height: 12)
                    .foregroundColor(changeRatio?.color ?? .secondary)
                Text(changeRatio?.pretty(precision: 2, numberStyle: .percent, negativePrefix: "") ?? "-")
                    .font(.subheadline)
                    .foregroundColor(changeRatio?.color ?? .secondary)
            }
        }
        .lineLimit(1)
    }
    
}

private struct CurrencyLogo: View {
    
    let currencyId: String
    
    var body: some View {
        if let _ = UIImage(named: currencyId) {
            Image(currencyId)
                .resizable()
        } else {
            currencyLetterLogo
        }
    }
    
    private var currencyLetterLogo: some View {
        ZStack {
            Circle()
                .fill(currencyId.generatedColor)
            Text(currencyId.first?.uppercased() ?? "-")
                .font(.headline)
                .foregroundColor(.white)
        }
    }
    
}

private struct TrendIcon: View {
    
    enum Variant {
        
        case up
        case neutral
        case down
        
    }
    
    let variant: Variant
    
    private let radiusRatio: CGFloat = 0.16
    
    var body: some View {
        GeometryReader { geometry in
            switch variant {
            case .up:
                triangleIcon
            case .neutral:
                RoundedRectangle(cornerRadius: geometry.size.height / 4)
            case .down:
                triangleIcon
                    .rotationEffect(.radians(.pi))
            }
        }
    }
    
    private var triangleIcon: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            Path { path in
                let radius = min(width, height) * radiusRatio
                let radiusHalf = radius / 2
                
                let bottomLeftPoint = CGPoint(
                    x: -radiusHalf,
                    y: height - radiusHalf
                )
                let topPoint = CGPoint(
                    x: width / 2,
                    y: -radiusHalf
                )
                let bottomRightPoint = CGPoint(
                    x: width + radiusHalf,
                    y: height - radiusHalf
                )
                
                let midPoint = CGPoint(
                    x: (bottomLeftPoint.x + topPoint.x) / 2,
                    y: (bottomLeftPoint.y + topPoint.y) / 2
                )
                
                path.move(to: midPoint)
                path.addArc(
                    tangent1End: topPoint,
                    tangent2End: bottomRightPoint,
                    radius: radius
                )
                path.addArc(
                    tangent1End: bottomRightPoint,
                    tangent2End: bottomLeftPoint,
                    radius: radius
                )
                path.addArc(
                    tangent1End: bottomLeftPoint,
                    tangent2End: topPoint,
                    radius: radius
                )
            }
        }
    }
    
}

private extension Double {
    
    var trendIconVariant: TrendIcon.Variant {
        if self > 0 {
            return .up
        } else if self < 0 {
            return .down
        } else {
            return .neutral
        }
    }
    
}

extension Ticker {
    
    var tickerRow: TickerRow {
        .init(
            firstCurrencyId: firstCurrency.id,
            secondCurrencyId: secondCurrency.id,
            rate: rate,
            ratePrecision: secondCurrency.precision,
            changeRatio: changeRatio
        )
    }
    
}

#if DEBUG

struct TickerRow_Previews: PreviewProvider {
    
    static var previews: some View {
        TickerRow(
            firstCurrencyId: "btc",
            secondCurrencyId: "pln",
            rate: 11.22,
            ratePrecision: 2,
            changeRatio: 0.1234
        )
    }
    
}

#endif
