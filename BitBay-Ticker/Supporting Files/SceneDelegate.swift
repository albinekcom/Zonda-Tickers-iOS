import SwiftUI

final class SceneDelegate: UIResponder {
    
    var window: UIWindow?
    
    private let userData: UserData = UserData()
    
}

extension SceneDelegate: UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIHostingController(rootView: Main().environmentObject(userData))
        window?.makeKeyAndVisible()
        
        userData.loadUserData { [weak self] in
            self?.userData.setupRefreshingTimer()
            
            self?.userData.refreshAllTickers()
            self?.userData.refreshTickersIdentifiers()
        }
        
        UserDefaultsManager().incrementApplicationLaunchCounter()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        userData.saveUserData()
    }
}
