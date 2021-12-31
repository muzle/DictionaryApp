import UIKit

extension UIView {
    func getSubviewFrame(view: UIView) -> CGRect? {
        guard let origin = view.superview else { return nil }
        return origin.convert(view.frame, to: self)
    }
}
