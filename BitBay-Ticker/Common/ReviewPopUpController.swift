import StoreKit

struct ReviewPopUpController {
    
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
        userDefaultsManager.applicationLaunchCounter >= AppConfiguration.displayRatingPopUpEveryXApplicationLaunchTimes
    }
}
