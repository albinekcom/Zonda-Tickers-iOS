import SwiftUI

final class AdderViewController: UIHostingController<AdderView> {
    
    init(dataRepository: DataRepository) {
        super.init(rootView: .init(viewModel: .init(dataRepository: dataRepository)))
        
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .close,
                                                 target: self,
                                                 action: #selector(closeButtonTap))
        
        title = "Add Ticker".localized
    }
    
    @objc private func closeButtonTap() {
        dismiss(animated: true)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
