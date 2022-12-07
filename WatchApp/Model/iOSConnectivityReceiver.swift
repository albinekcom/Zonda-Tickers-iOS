import WatchConnectivity

protocol ConnectivityReceiver: AnyObject {
    
    var delegate: ConnectivityReceiverDelegate? { get set }
}

protocol ConnectivityReceiverDelegate: AnyObject {
    
    func userTickerIdsDidUpdate(userTickerIds: [String])
}

final class iOSConnectivityReceiver: NSObject {
    
    private let session: WCSession
    
    weak var delegate: ConnectivityReceiverDelegate?
    
    init(session: WCSession = .default) {
        self.session = session
        
        super.init()
        
        session.delegate = self
        session.activate()
    }
    
}

extension iOSConnectivityReceiver: WCSessionDelegate {
    
    func session(
        _ session: WCSession,
        didReceiveApplicationContext applicationContext: [String: Any]
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let userTickerIds = applicationContext[WatchConnectivityKey.Parameter.userTickerIds] as? [String] else { return }
                
            self?.delegate?.userTickerIdsDidUpdate(userTickerIds: userTickerIds)
        }
    }
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {}
    
}
