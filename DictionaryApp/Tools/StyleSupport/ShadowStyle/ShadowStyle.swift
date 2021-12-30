import UIKit

public protocol ShadowStyleType {
    var color: CGColor { get }
    var opacity: Float { get }
    var offset: CGSize { get }
    var radius: CGFloat { get }
}

// MARK: - Implement ShadowStyleType

struct ShadowStyle: ShadowStyleType, AutoSetable {
    var color: CGColor
    var opacity: Float
    var offset: CGSize
    var radius: CGFloat
    
    init(
        color: CGColor = UIColor.black.cgColor,
        opacity: Float = 0.1,
        offset: CGSize = .init(width: 0, height: 1),
        radius: CGFloat = 3
    ) {
        self.color = color
        self.opacity = opacity
        self.offset = offset
        self.radius = radius
    }
    
    static let zero = Self(color: UIColor.clear.cgColor, opacity: .zero, offset: .zero, radius: .zero)
}
