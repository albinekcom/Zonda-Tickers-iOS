struct SupportedTickersAPIResponse: Codable {
    
    let supportedTickers: [String]?
    let names: [String: String]?
    let sortOrder: [String]?
    
}
