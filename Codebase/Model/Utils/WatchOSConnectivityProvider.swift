import WatchConnectivity

protocol ConnectivityProvider: AnyObject {
    
    func send(userTickerIds: [String])
    
    var delegate: ConnectivityProviderDelegate? { get set }
}

protocol ConnectivityProviderDelegate: AnyObject {
    
    var userTickerIds: [String] { get }
}

final class WatchOSConnectivityProvider: NSObject, ConnectivityProvider {
    
    private let session: WCSession
    
    weak var delegate: ConnectivityProviderDelegate?
    
    init(session: WCSession = .default) {
        self.session = session
        
        super.init()
        
        session.delegate = self
        session.activate()
    }
    
    func send(userTickerIds: [String]) {
        try? session.updateApplicationContext(["userTickerIds": userTickerIds])
    }
    
}

extension WatchOSConnectivityProvider: WCSessionDelegate {
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {}
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
    
}
