import StoreKit

final class ReviewController {
    
    static let counterMaximum = 10
    static let counterKey = "counter"
    
    private let analyticsService: AnalyticsService?
    
    private let storeReviewControllerType: SKStoreReviewController.Type
    private let userDefaults: UserDefaults
    
    private var counter: Int {
        get {
            userDefaults.integer(forKey: Self.counterKey)
        }
        set {
            userDefaults.set(newValue, forKey: Self.counterKey)
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
        storeReviewControllerType: SKStoreReviewController.Type = SKStoreReviewController.self,
        userDefaults: UserDefaults = .standard
    ) {
        self.analyticsService = analyticsService
        self.storeReviewControllerType = storeReviewControllerType
        self.userDefaults = userDefaults
    }
    
    func tryToDisplay() {
        counter += 1
        
        if counter >= Self.counterMaximum, let windowScene = windowScene {
            counter = 0
            
            storeReviewControllerType.requestReview(in: windowScene)
            
            analyticsService?.trackReviewRequested()
        }
    }
    
}
