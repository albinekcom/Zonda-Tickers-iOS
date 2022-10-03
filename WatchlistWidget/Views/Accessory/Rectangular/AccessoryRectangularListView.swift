import SwiftUI

struct AccessoryRectangularListView: View {
    
    private let rowsModel: [AccessoryRectangularRow.Model]
    private let maximumCount: Int
    
    init(
        tickers: [Ticker]?,
        maximumCount: Int
    ) {
        rowsModel = tickers.rowModels(maximumCount: maximumCount)
        self.maximumCount = maximumCount
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ForEach(rowsModel, id: \.title) {
                    AccessoryRectangularRow(model: $0)
                        .frame(height: proxy.size.height / CGFloat(maximumCount))
                }
                Spacer()
            }
        }
    }
    
}

private extension Ticker {
    
    var accessoryRectangularRow: AccessoryRectangularRow.Model {
        .init(
            icon: changeImageName,
            title: firstCurrencyText + "\\" + secondCurrencyText,
            valueText: rateText,
            isGain: (change ?? 0) > 0
        )
    }
    
}

private extension Optional where Wrapped == Array<Ticker> {
    
    func rowModels(maximumCount: Int) -> [AccessoryRectangularRow.Model] {
        guard let self = self else { return (1...maximumCount).map { _ in .placeholder } }

        return self
            .firstElements(maximumCount: maximumCount)
            .map(\.accessoryRectangularRow)
    }
    
}

private extension AccessoryRectangularRow.Model {
    
    static let placeholder: Self = .init(
        icon: .squareFill,
        title: "-\\-",
        valueText: "-",
        isGain: false
    )
    
}
