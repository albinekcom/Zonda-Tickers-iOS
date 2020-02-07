import SwiftUI

struct TickerDetailViewModel {
    
    enum Row: CaseIterable {
        case name
        case rate
        case previousRate
        case highestRate
        case lowestRate
        case highestBid
        case lowestAsk
        case average
        case volume
    }
    
    let model: Ticker
    
    var navigationBarTitle: Text {
        Text(TickerIdentifiersStore.shared.tickerIdentifierOrCreateNew(id: model.id).prettyTitle)
    }
    
    func title(for row: Row) -> Text {
        switch row {
        case .name:
            return Text("Name")
            
        case .rate:
            return Text("Last")
            
        case .previousRate:
            return Text("Previous")
            
        case .highestRate:
            return Text("Maximum")
            
        case .lowestRate:
            return Text("Minimum")
            
        case .highestBid:
            return Text("Bid")
            
        case .lowestAsk:
            return Text("Ask")
            
        case .average:
            return Text("Average")
            
        case .volume:
            return Text("Volume")
        }
    }
    
    func value(for row: Row) -> String {
        let scale = model.secondCurrency?.scale
        
        switch row {
        case .name:
            return TickerIdentifiersStore.shared.tickerIdentifier(id: model.id)?.firstCurrencyName ?? "-"
            
        case .rate:
            return PrettyValueFormatter.makePrettyString(value: model.rate, scale: scale, currency: nil)
            
        case .previousRate:
            return PrettyValueFormatter.makePrettyString(value: model.previousRate, scale: scale, currency: nil)
            
        case .highestRate:
            return PrettyValueFormatter.makePrettyString(value: model.highestRate, scale: scale, currency: nil)
            
        case .lowestRate:
            return PrettyValueFormatter.makePrettyString(value: model.lowestRate, scale: scale, currency: nil)
            
        case .highestBid:
            return PrettyValueFormatter.makePrettyString(value: model.highestBid, scale: scale, currency: nil)
            
        case .lowestAsk:
            return PrettyValueFormatter.makePrettyString(value: model.lowestAsk, scale: scale, currency: nil)
            
        case .average:
            return PrettyValueFormatter.makePrettyString(value: model.average, scale: scale, currency: nil)
            
        case .volume:
            return PrettyValueFormatter.makePrettyString(value: model.volume, scale: scale, currency: nil)
        }
    }
    
}
