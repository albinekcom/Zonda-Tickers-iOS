import Combine
import SwiftUI

final class ListViewController: UIHostingController<ListView> {
    
    private let viewModel: ListViewModel
    private let addButtonTapAction: (() -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataRepository: DataRepository,
         rowTapAction: ((String) -> Void)?,
         addButtonTapAction: (() -> Void)?) {
        self.addButtonTapAction = addButtonTapAction
        
        viewModel = .init(dataRepository: dataRepository, rowTapAction: rowTapAction)
        
        super.init(rootView: .init(viewModel: self.viewModel))
        
        title = "Tickers".localized
        
        setUpNavigationBarButtonItems()
        
        setUpBindings()
    }
    
    // MARK: - Managing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let activeScene = UIApplication.shared.activeScene else { return }
            
            ReviewController().tryToDisplay(in: activeScene)
        }
    }
    
    private func setUpNavigationBarButtonItems() {
        navigationItem.leftBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        editButtonItem.action = #selector(editButtonTapped)
    }
    
    private func setUpBindings() {
        viewModel.$editMode
            .map(\.isEditing)
            .weakAssign(to: \.isEditing, on: self)
            .store(in: &cancellables)
        
        viewModel.$isEditingPossible
            .weakAssign(to: \.isEnabled, on: editButtonItem)
            .store(in: &cancellables)
    }
    
    @objc private func editButtonTapped() {
        withAnimation {
            viewModel.editMode = viewModel.editMode.isEditing ? .inactive : .active
        }
    }
    
    @objc private func addButtonTapped() {
        addButtonTapAction?()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

private extension UIApplication {
    
    var activeScene: UIWindowScene? {
        connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
    
}
