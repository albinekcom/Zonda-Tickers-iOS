struct AvailableTickersAPIResponse: Codable {
    
    let data: DataAPIResponse?
    
    struct DataAPIResponse: Codable {
        
        let availableTickers: [String]?
        let sortingOrder: [String]?
        let fullNames: [String: String]?
        
    }
    
}
