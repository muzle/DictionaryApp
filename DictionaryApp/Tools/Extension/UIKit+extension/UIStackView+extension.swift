import UIKit

extension UIStackView {
    func removeArrangedSubviews() {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func addArrangedSubview(contentsOf views: [UIView]) {
        views.forEach(addArrangedSubview(_:))
    }
}
