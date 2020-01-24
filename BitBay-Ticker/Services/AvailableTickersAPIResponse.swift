struct AvailableTickersAPIResponse: Codable {
    
    struct DataAPIResponse: Codable {
        
        let availableTickers: [String]?
        let sortingOrder: [String]?
        let fullNames: [String: String]?
        
    }
    
    let data: DataAPIResponse?
    
}

