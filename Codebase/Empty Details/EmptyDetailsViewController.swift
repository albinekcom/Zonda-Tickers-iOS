import SwiftUI

final class EmptyDetailsViewController: UIHostingController<EmptyDetailsView> {
    
    init() {
        super.init(rootView: .init())
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
