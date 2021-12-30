import Foundation
import UIKit

protocol TextStyleType {
    var font: UIFont { get }
    var color: UIColor { get }
    var alignment: NSTextAlignment { get }
    var numberOfLines: Int { get }
    var needStrike: Bool { get }
}

extension TextStyleType {
    var numberOfLines: Int { 0 }
    var needStrike: Bool { false }
}

// MARK: - Implement TextStyleType

struct TextStyle: TextStyleType, AutoSetable {
    var font: UIFont
    var color: UIColor
    var alignment: NSTextAlignment
    var numberOfLines: Int
    var needStrike: Bool
    
    init(
        font: UIFont,
        color: UIColor,
        alignment: NSTextAlignment,
        numberOfLines: Int = 0,
        needStrike: Bool = false
    ) {
        self.font = font
        self.color = color
        self.alignment = alignment
        self.numberOfLines = numberOfLines
        self.needStrike = needStrike
    }
}
