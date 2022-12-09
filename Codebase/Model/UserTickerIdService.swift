final class UserTickerIdService {
    
    private let localDataService: LocalDataService
    
    init(localDataService: LocalDataService = FileManagerDataService()) {
        self.localDataService = localDataService
    }
    
    var loaded: [String] {
        localDataService.loadUserTickerIds()
    }
    
    func save(userTickerIds: [String]) {
        localDataService.save(userTickerIds: userTickerIds)
    }
    
}
