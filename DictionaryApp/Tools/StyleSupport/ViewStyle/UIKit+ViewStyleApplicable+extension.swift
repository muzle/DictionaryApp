import UIKit

// MARK: - UIView + ViewStyleApplicable

extension UIView: ViewStyleApplicable {
    func applyViewStyle(_ style: ViewStyleType) {
        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius ?? 0
        layer.borderWidth = style.borderWidth ?? 0
        layer.borderColor = style.borderColor
        if let shadow = style.shadowStyle {
            layer.applyShadowStyle(shadow)
        } else {
            layer.removeShadow()
        }
        
        if let textStyle = style.textStyle, let applicable = self as? TextStyleApplicable {
            applicable.applyTextStyle(textStyle)
        }
    }
}

// MARK: - UIViewController + ViewStyleApplicable

extension UIViewController: ViewStyleApplicable {
    func applyViewStyle(_ style: ViewStyleType) {
        view.applyViewStyle(style)
    }
}
