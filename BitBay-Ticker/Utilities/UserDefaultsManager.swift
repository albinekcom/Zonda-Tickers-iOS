import Foundation

final class UserDefaultsManager {
    
    var applicationLaunchCounter: Int {
        get {
            userDefaults?.integer(forKey: AppConfiguration.Storing.applicationLaunchCounterKey) ?? 0
        }
        set {
            userDefaults?.set(newValue, forKey: AppConfiguration.Storing.applicationLaunchCounterKey)
        }
    }
    
    let userDefaults: UserDefaults?
    
    init(userDefaults: UserDefaults? = UserDefaults.shared) {
        self.userDefaults = userDefaults
    }
    
    func incrementApplicationLaunchCounter() {
        applicationLaunchCounter += 1
    }
    
    func resetApplicationLaunchCounter() {
        applicationLaunchCounter = 0
    }
    
}
