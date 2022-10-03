import SwiftUI

@main
private struct WatchApp: App {
    
    @StateObject private var userTickerStore = UserTickerStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
                    .environmentObject(userTickerStore)
            }
        }
    }
    
}

// TODO:
// - Add complications
