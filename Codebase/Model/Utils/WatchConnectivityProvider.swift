import WatchConnectivity

protocol ConnectivityProvider: AnyObject {
    
    func send(userTickerIds: [String])
    
    var delegate: WatchConnectivityProviderDelegate? { get set }
}

protocol WatchConnectivityProviderDelegate: AnyObject {
    
    var userTickerIds: [String] { get }
}

protocol WCSessionProtocol: AnyObject {
    
    func activate()
    func updateApplicationContext(_ applicationContext: [String: Any]) throws
    
    var delegate: WCSessionDelegate? { get set }
}

extension WCSession: WCSessionProtocol {}

final class WatchConnectivityProvider: NSObject, ConnectivityProvider {
    
    private let session: WCSessionProtocol
    
    weak var delegate: WatchConnectivityProviderDelegate?
    
    init(session: WCSessionProtocol = WCSession.default) {
        self.session = session
        
        super.init()
        
        session.delegate = self
        session.activate()
    }
    
    func send(userTickerIds: [String]) {
        try? session.updateApplicationContext([WatchConnectivityKey.Parameter.userTickerIds: userTickerIds])
    }
    
}

extension WatchConnectivityProvider: WCSessionDelegate {
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {}
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
    
}
