import Crashlytics
import Fabric
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {
    
    var window: UIWindow?
    
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        BuddyBuildSDK.setup()
        Fabric.with([Crashlytics.self])
        
        TickerStore.shared.loadUserData()
        
        return true
    }
    
}
