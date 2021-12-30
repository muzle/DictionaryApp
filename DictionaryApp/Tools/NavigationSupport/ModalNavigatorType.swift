import class UIKit.UIViewController

protocol ModalNavigatorType: AnyObject, AlertPresentable {
    typealias Item = UIViewController

    func present(_ item: Item, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func dismissFullPresentedStack(completion: (() -> Void)?)
    var topPresentedItem: ModalNavigatorType? { get }
}

extension ModalNavigatorType {
    func present(_ item: Item, animated: Bool) {
        present(item, animated: animated, completion: .none)
    }

    func dismiss(_ animated: Bool) {
        topPresentedItem?.dismiss(animated: animated, completion: .none)
    }
}

// MARK: - UIKit.UIViewController implement ModalNavigatorType

extension UIViewController: ModalNavigatorType {
    func dismissFullPresentedStack(completion: (() -> Void)?) {
        var item = self
        guard item.presentingViewController != nil || item.presentedViewController != nil else {
            completion?()
            return
        }
        while let presented = item.presentedViewController {
            item = presented
        }
        while let presenting = item.presentingViewController {
            item = presenting
            if item.presentingViewController != nil {
                item.dismiss(false, completion: nil)
            } else {
                item.dismiss(false, completion: completion)
            }
        }
    }
    
    func dismiss(_ animated: Bool, completion: (() -> Void)?) {
        presentedViewController?.dismiss(animated: animated, completion: completion)
    }
    
    var topPresentedItem: ModalNavigatorType? {
        var item = self
        while let presented = item.presentedViewController {
            item = presented
        }
        return item.navigationController ?? item
    }
}
