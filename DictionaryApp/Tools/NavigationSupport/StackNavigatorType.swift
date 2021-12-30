import class UIKit.UIViewController
import class UIKit.UINavigationController

protocol StackNavigatorType: AnyObject {
    typealias Item = UIViewController

    func push(_ item: Item, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool, completion: (() -> Void)?)
    func setNavigationBarHidden(_ hidden: Bool, animated: Bool)
    func popToRoot(animated: Bool, completion: (() -> Void)?)
}

// MARK: - Provides behaviour

extension StackNavigatorType {
    func push(_ item: Item, animated: Bool) {
        push(item, animated: animated, completion: .none)
    }
    func pop(animated: Bool) {
        pop(animated: animated, completion: .none)
    }
    func popToRoot(animated: Bool) {
        popToRoot(animated: animated, completion: .none)
    }
}
