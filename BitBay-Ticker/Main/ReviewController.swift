import StoreKit
import UIKit

final class ReviewController {
    
    private static let successfulRefreshCountThresholdToDisplayReview = 5
    private static let successfulRefreshCountKey = "successful_refresh_count"
    
    private(set) var successfulRefreshCount = 0 {
        didSet {
            userDefaults?.set(successfulRefreshCount, forKey: ReviewController.successfulRefreshCountKey)
            userDefaults?.synchronize()
        }
    }
    
    private let userDefaults: UserDefaults?
    
    init(userDefaults: UserDefaults?) {
        self.userDefaults = userDefaults
        
        if let successfulRefreshCount = userDefaults?.integer(forKey: ReviewController.successfulRefreshCountKey) {
            self.successfulRefreshCount = successfulRefreshCount
        }
    }
    
    func incrementSuccessfulRefreshCount() {
        if let successfulRefreshCount = userDefaults?.integer(forKey: ReviewController.successfulRefreshCountKey) {
            self.successfulRefreshCount = successfulRefreshCount
        }
        
        successfulRefreshCount += 1
    }
    
    func clearSuccessfulRefreshCount() {
        successfulRefreshCount = 0
    }
    
    var shouldDisplayReviewController: Bool {
        return successfulRefreshCount >= ReviewController.successfulRefreshCountThresholdToDisplayReview
    }
    
    func displayReviewController() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }
    
}
