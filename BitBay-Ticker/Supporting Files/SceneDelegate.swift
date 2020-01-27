import SwiftUI

final class SceneDelegate: UIResponder {
    
    var window: UIWindow?
    
    private let userData: UserData = UserData()
    private let dataStorage: DataStorage = DataStorage()
    
}

extension SceneDelegate: UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIHostingController(rootView: Main().environmentObject(userData))
        window?.makeKeyAndVisible()
        
        dataStorage.userData = userData
        dataStorage.loadUserData()
        
        UserDefaultsManager().incrementApplicationLaunchCounter()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        dataStorage.saveUserData()
    }
    
}
