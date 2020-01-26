import Foundation

final class UserDefaultsManager {
    
    var applicationLaunchCounter: Int {
        get {
            userDefaults.integer(forKey: AppConfiguration.Storing.applicationLaunchCounterKey)
        }
        set {
            userDefaults.set(newValue, forKey: AppConfiguration.Storing.applicationLaunchCounterKey)
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
