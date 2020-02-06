struct SupportedTickersAPIResponse: Codable {
    
    let supportedTickers: [String]?
    let fullNames: [String: String]?
    let sortingOrder: [String]?
    
}
