import UIKit

protocol ViewStyleType {
    var backgroundColor: UIColor? { get }
    var cornerRadius: CGFloat? { get }
    var borderWidth: CGFloat? { get }
    var borderColor: CGColor? { get }
    
    var shadowStyle: ShadowStyle? { get }
    var textStyle: TextStyle? { get }
}

struct ViewStyle: ViewStyleType, AutoSetable {
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
    var borderWidth: CGFloat?
    var borderColor: CGColor?
    
    var shadowStyle: ShadowStyle?
    var textStyle: TextStyle?
    
    init(
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        borderColor: CGColor? = nil,
        shadowStyle: ShadowStyle? = nil,
        textStyle: TextStyle? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.shadowStyle = shadowStyle
        self.textStyle = textStyle
    }
}
