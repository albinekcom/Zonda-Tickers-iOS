import SwiftUI

final class SceneDelegate: UIResponder {
    
    var window: UIWindow?
    
    private let userData: UserData = UserData()
    
}

extension SceneDelegate: UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIHostingController(rootView: TickerList().environmentObject(userData))
        window?.makeKeyAndVisible()
        
        userData.loadUserData()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        userData.saveUserData()
    }
}
