import StoreKit

struct ReviewPopUpController {
    
    private let displayRatingPopUpEveryXApplicationLaunchTimes = 10
    private let userDefaultsManager: UserDefaultsManager
    
    init(userDefaultsManager: UserDefaultsManager = UserDefaultsManager()) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func displayReviewPopUpIfNeeded() {
        guard shouldDisplayReviewPopUp else { return }
        
        userDefaultsManager.resetApplicationLaunchCounter()
        SKStoreReviewController.requestReview()
        AnalyticsService.shared.trackRequestedRatingView()
    }
    
    var shouldDisplayReviewPopUp: Bool {
        userDefaultsManager.applicationLaunchCounter >= displayRatingPopUpEveryXApplicationLaunchTimes
    }
}
