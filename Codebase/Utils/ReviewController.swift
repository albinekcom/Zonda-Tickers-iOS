import StoreKit

final class ReviewController {
    
    private let analyticsService: AnalyticsService?
    
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
    
    private var windowScene: UIWindowScene? {
        UIApplication
            .shared
            .connectedScenes
            .first as? UIWindowScene
    }
    
    init(
        analyticsService: AnalyticsService?,
        storeReviewController: SKStoreReviewController.Type = SKStoreReviewController.self,
        userDefaults: UserDefaults = .standard
    ) {
        self.analyticsService = analyticsService
        self.storeReviewController = storeReviewController
        self.userDefaults = userDefaults
    }
    
    func tryToDisplay() {
        counter += 1
        
        if counter >= counterMaximum, let windowScene = windowScene {
            counter = 0
            
            storeReviewController.requestReview(in: windowScene)
            
            analyticsService?.trackReviewRequested()
        }
    }
    
}
