import SwiftUI

struct TickerDetailViewModel {
    
    enum Row {
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
        let value: Double?
        let scale = model.secondCurrency?.scale
        var currencyString = model.secondCurrency?.currency
        
        switch row {
        case .rate:
            value = model.rate
            
        case .previousRate:
            value = model.previousRate
            
        case .highestRate:
            value = model.highestRate
            
        case .lowestRate:
            value = model.lowestRate
            
        case .highestBid:
            value = model.highestBid
            
        case .lowestAsk:
            value = model.lowestAsk
            
        case .average:
            value = model.average
            
        case .volume:
            value = model.volume
            currencyString = nil
        }
        
        return PrettyValueFormatter.makePrettyString(value: value, scale: scale, currency: currencyString)
    }
    
}
