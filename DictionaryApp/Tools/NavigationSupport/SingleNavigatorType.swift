import UIKit

protocol SingleNavigatorType: AnyObject {
    typealias Item = UIViewController
    func put(_ item: Item)
}

// MARK: - UIKit.UIWindow + SingleNavigatorType + extension

extension UIWindow: SingleNavigatorType {
    func put(_ item: Item) {
        rootViewController = item
    }
}
