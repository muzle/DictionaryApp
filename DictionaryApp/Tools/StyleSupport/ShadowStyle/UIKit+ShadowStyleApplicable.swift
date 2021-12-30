import UIKit

// MARK: - CALayer implement ShadowStyleApplicable

extension CALayer: ShadowStyleApplicable {
    public func applyShadowStyle(_ style: ShadowStyleType) {
        masksToBounds = false
        shadowColor = style.color
        shadowOpacity = style.opacity
        shadowOffset = style.offset
        shadowRadius = style.radius
    }
    
    public func removeShadow() {
        shadowColor = nil
        shadowOpacity = 0
        shadowOffset = .zero
        shadowRadius = 0
    }
}

// MARK: - UIView + ShadowStyleApplicable

extension UIView: ShadowStyleApplicable {
    public func applyShadowStyle(_ style: ShadowStyleType) {
        layer.applyShadowStyle(style)
    }
}
