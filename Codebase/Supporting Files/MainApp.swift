import SwiftUI

@main
private struct MainApp: App {
    
    @StateObject private var modelData = ModelData()
    @StateObject private var appEnvironment = AppEnvironment(analyticsService: FirebaseAnalyticsService())
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(modelData)
                .environmentObject(appEnvironment)
        }
        .onChange(of: scenePhase) {
            switch $0 {
            case .active:
                modelData.analyticsService = appEnvironment.analyticsService
                modelData.reloadLocalTickers()
                
            default:
                break
            }
        }
    }
    
}
