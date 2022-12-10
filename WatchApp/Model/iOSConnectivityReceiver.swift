import WatchConnectivity

protocol ConnectivityReceiver: AnyObject {
    
    var delegate: ConnectivityReceiverDelegate? { get set }
}

protocol ConnectivityReceiverDelegate: AnyObject {
    
    func userTickerIdsDidUpdate(userTickerIds: [String])
    func userDidUpdate(tickers: [Ticker]?, userTickerIds: [String]?)
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
    
    private func process(message: [String: Any]) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.userDidUpdate(
                tickers: (message[WatchConnectivityKey.Parameter.tickers] as? Data)?.tickers,
                userTickerIds: message[WatchConnectivityKey.Parameter.userTickerIds] as? [String]
            )
        }
    }
    
}

extension iOSConnectivityReceiver: WCSessionDelegate {
    
    func session(
        _ session: WCSession,
        didReceiveApplicationContext applicationContext: [String: Any]
    ) {
        process(message: applicationContext)
    }
    
    func session(
        _ session: WCSession,
        didReceiveUserInfo userInfo: [String: Any]
    ) {
        process(message: userInfo)
    }
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {}
    
}

private extension Data {
    
    var tickers: [Ticker]? {
        try? JSONDecoder().decode([Ticker].self, from: self)
    }
    
}
