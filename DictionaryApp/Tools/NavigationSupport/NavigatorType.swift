import UIKit.UINavigationController

protocol NavigatorType: EmptyNavigatorType, ModalNavigatorType, StackNavigatorType, SingleNavigatorType {
}

// MARK: - UIKit.UINavigationController implement NavigatorType

extension UINavigationController: NavigatorType {
    private func attachToTransitioningCoordinator(_ completion: (() -> Void)?) {
        let completion = completion ?? {}
        guard let coordinator = self.transitionCoordinator,
            coordinator.animate(alongsideTransition: nil, completion: { _ in completion() })
        else {
            return completion()
        }
    }
    
    func push(_ item: UIViewController, animated: Bool, completion: (() -> Void)?) {
        pushViewController(item, animated: animated)
        attachToTransitioningCoordinator(completion)
    }

    func pop(animated: Bool, completion: (() -> Void)?) {
        popViewController(animated: animated)
        attachToTransitioningCoordinator(completion)
    }
    
    func popToRoot(animated: Bool, completion: (() -> Void)?) {
        popToRootViewController(animated: animated)
        attachToTransitioningCoordinator(completion)
    }
    func put(_ item: UIViewController) {
        setViewControllers([item], animated: false)
    }
}
