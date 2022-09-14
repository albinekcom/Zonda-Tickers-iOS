import Foundation

final class AppEnvironment: ObservableObject {
    
    let analyticsService = FirebaseAnalyticsService(firebaseConfigurableType: ServiceFactory().makeFirebaseConfigurableType())
    
}
