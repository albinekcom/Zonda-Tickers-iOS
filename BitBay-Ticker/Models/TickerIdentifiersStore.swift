final class TickerIdentifiersStore {
    
    static let shared: TickerIdentifiersStore = TickerIdentifiersStore()
    
    var tickerIdentifiers: [TickerIdentifier] = []
    
    func tickerIdentifier(id: String) -> TickerIdentifier? {
        tickerIdentifiers.first(where: { $0.id == id })
    }
    
    func tickerIdentifierOrCreateNew(id: String) -> TickerIdentifier {
        tickerIdentifier(id: id) ?? TickerIdentifier(id: id)
    }
    
}
