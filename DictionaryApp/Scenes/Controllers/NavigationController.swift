import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.apply {
            $0.tintColor = Asset.navigationBarTintColor.color
            $0.barTintColor = Asset.navigationBarTintColor.color
            $0.backgroundColor = Asset.navigationBarBackgroundColor.color
        }
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Asset.navigationBarBackgroundColor.color
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
        
        view.backgroundColor = Asset.commonBackgroundColor.color
        navigationBar.titleTextAttributes = [
            .font: FontFactory.Message.medium,
            .foregroundColor: Asset.commonTextColor.color
        ]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        viewController.navigationItem.backBarButtonItem = backButton
        super.pushViewController(viewController, animated: animated)
    }
    
}
