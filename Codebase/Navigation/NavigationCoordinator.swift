import UIKit

final class NavigationCoordinator {
    
    let splitViewController = UISplitViewController()
    
    private let dataRepository = DataRepository()
    
    init() {
        let listViewController = ListViewController(
            dataRepository: dataRepository,
            rowTapAction: { [weak self] tickerId in self?.showDetails(tickerId: tickerId) },
            addButtonTapAction: { [weak self] in self?.showAdder() }
        )
        
        let navigationControllerForListViewController = UINavigationController(rootViewController: listViewController)
        navigationControllerForListViewController.navigationBar.prefersLargeTitles = true
        
        splitViewController.preferredDisplayMode = .oneBesideSecondary
        splitViewController.viewControllers = [
            navigationControllerForListViewController,
            EmptyDetailsViewController()
        ]
        splitViewController.delegate = self
    }
    
    private func showDetails(tickerId: String) {
        let detailsViewController = DetailsViewController(
            dataRepository: dataRepository,
            tickerId: tickerId
        )
        
        let navigationControllerForDetailsViewController = UINavigationController(rootViewController: detailsViewController)
        navigationControllerForDetailsViewController.navigationBar.prefersLargeTitles = true
        
        splitViewController.showDetailViewController(
            navigationControllerForDetailsViewController,
            sender: nil
        )
    }
    
    private func showAdder() {
        let adderViewController = AdderViewController(
            dataRepository: dataRepository
        )
        
        splitViewController.present(
            UINavigationController(rootViewController: adderViewController),
            animated: true
        )
    }
    
}

extension NavigationCoordinator: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool { true }
    
}
