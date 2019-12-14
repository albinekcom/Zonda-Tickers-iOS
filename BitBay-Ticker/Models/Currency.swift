struct Currency: Hashable, Codable, Equatable {
    
    let currency: String
    let minimumOffer: Double
    let scale: Int
    
}
