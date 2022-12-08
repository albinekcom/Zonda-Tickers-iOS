import SwiftUI

struct AccessoryRectangularRowView: View {
    
    let ticker: Ticker?
    
    var body: some View {
        HStack {
            HStack(spacing: 2) {
                Image(systemName: ticker.changeImageName)
                    .rotationEffect(.radians(ticker.change > 0 ? 0 : .pi))
                    .foregroundColor(ticker.changeColor)
                Text(ticker.shortTitle)
            }
            .layoutPriority(1)
            
            Spacer()
            
            Text(ticker.rateText)
                .foregroundColor(ticker.changeColor)
        }
    }
    
}
