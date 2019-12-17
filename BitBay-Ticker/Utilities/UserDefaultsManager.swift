import Foundation

final class UserDefaultsManager {
    
    private let applicationLaunchCounterKey = "application_launch_counter"
    
    var applicationLaunchCounter: Int {
        get {
             userDefaults.integer(forKey: applicationLaunchCounterKey)
        }
        set {
            userDefaults.set(newValue, forKey: applicationLaunchCounterKey)
            userDefaults.synchronize()
        }
    }
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func incrementApplicationLaunchCounter() {
        applicationLaunchCounter += 1
    }
    
    func resetApplicationLaunchCounter() {
        applicationLaunchCounter = 0
    }
    
}
