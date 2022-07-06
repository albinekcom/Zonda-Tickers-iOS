import StoreKit

final class ReviewController {
    
    private let storeReviewController: SKStoreReviewController.Type
    private let userDefaults: UserDefaults
    
    private let counterMaximum = 10
    private let counterKey = "counter"
    private var counter: Int {
        get {
            userDefaults.integer(forKey: counterKey)
        }
        set {
            userDefaults.set(newValue, forKey: counterKey)
        }
    }
    
    init(storeReviewController: SKStoreReviewController.Type = SKStoreReviewController.self,
         userDefaults: UserDefaults = .standard) {
        self.storeReviewController = storeReviewController
        self.userDefaults = userDefaults
    }
    
    func tryToDisplay(in activeScene: UIWindowScene) {
        counter += 1
        
        if counter >= counterMaximum {
            counter = 0
            
            storeReviewController.requestReview(in: activeScene)
            
            AnalyticsService.shared.trackReviewRequested()
        }
    }
    
}
