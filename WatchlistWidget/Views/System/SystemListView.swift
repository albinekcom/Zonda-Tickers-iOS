import SwiftUI

struct SystemListView: View {
    
    private let rowsModel: [StandardRow.Model]
    private let maximumCount: Int
    private let isSystemSmall: Bool
    
    init(
        tickers: [Ticker]?,
        maximumCount: Int,
        isSystemSmall: Bool
    ) {
        rowsModel = tickers.rowModels(maximumCount: maximumCount)
        self.maximumCount = maximumCount
        self.isSystemSmall = isSystemSmall
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ForEach(rowsModel, id: \.name) {
                    $0.view(isSystemSmall: isSystemSmall)
                        .frame(height: proxy.size.height / CGFloat(maximumCount))
                        .padding(.horizontal)
                    Divider()
                }
                Spacer()
            }
        }
    }
    
}

private extension Optional where Wrapped == Array<Ticker> {
    
    func rowModels(maximumCount: Int) -> [StandardRow.Model] {
        guard let self = self else { return (1...maximumCount).map { _ in .placeholder } }

        return self
            .firstElements(maximumCount: maximumCount)
            .map(\.standardRowModel)
    }
    
}

private extension StandardRow.Model {
    
    @ViewBuilder
    func view(isSystemSmall: Bool) -> some View {
        if isSystemSmall {
            SystemSmallRow(model: self)
        } else {
            StandardRow(model: self)
        }
    }
    
}

private extension StandardRow.Model {
    
    static let placeholder: Self = .init(
        firstCurrencyId: nil,
        firstCurrencyText: "-",
        secondCurrencyText: "-",
        rateText: "-",
        percentageChangeWithoutSignText: "-",
        percentageChangeWithPositiveSignText: "-",
        changeImageName: .squareFill,
        changeColor: .secondary
    )
    
}
