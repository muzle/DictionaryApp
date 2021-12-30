// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import UIKit
import Foundation

// MARK: - Setable for classes, structs

// MARK: - ShadowStyle
extension ShadowStyle {
    enum Part {
        case color(CGColor)
        case opacity(Float)
        case offset(CGSize)
        case radius(CGFloat)
    }
    func byAdding(_ parts: Part...) -> ShadowStyle {
        byAdding(parts)
    }
    func byAdding(_ parts: [Part]) -> ShadowStyle {
        guard !parts.isEmpty else { return self }
        var value = self
        for part in parts {
            value.update(part)
        }
        return value
    }
    private mutating func update(_ part: Part) {
        switch part {
        case .color(let color):
            self.color = color
        case .opacity(let opacity):
            self.opacity = opacity
        case .offset(let offset):
            self.offset = offset
        case .radius(let radius):
            self.radius = radius
        }
    }
}
// MARK: - TextStyle
extension TextStyle {
    enum Part {
        case font(UIFont)
        case color(UIColor)
        case alignment(NSTextAlignment)
        case numberOfLines(Int)
        case needStrike(Bool)
    }
    func byAdding(_ parts: Part...) -> TextStyle {
        byAdding(parts)
    }
    func byAdding(_ parts: [Part]) -> TextStyle {
        guard !parts.isEmpty else { return self }
        var value = self
        for part in parts {
            value.update(part)
        }
        return value
    }
    private mutating func update(_ part: Part) {
        switch part {
        case .font(let font):
            self.font = font
        case .color(let color):
            self.color = color
        case .alignment(let alignment):
            self.alignment = alignment
        case .numberOfLines(let numberOfLines):
            self.numberOfLines = numberOfLines
        case .needStrike(let needStrike):
            self.needStrike = needStrike
        }
    }
}
// MARK: - ViewStyle
extension ViewStyle {
    enum Part {
        case backgroundColor(UIColor?)
        case cornerRadius(CGFloat?)
        case borderWidth(CGFloat?)
        case borderColor(CGColor?)
        case shadowStyle(ShadowStyle?)
        case textStyle(TextStyle?)
    }
    func byAdding(_ parts: Part...) -> ViewStyle {
        byAdding(parts)
    }
    func byAdding(_ parts: [Part]) -> ViewStyle {
        guard !parts.isEmpty else { return self }
        var value = self
        for part in parts {
            value.update(part)
        }
        return value
    }
    private mutating func update(_ part: Part) {
        switch part {
        case .backgroundColor(let backgroundColor):
            self.backgroundColor = backgroundColor
        case .cornerRadius(let cornerRadius):
            self.cornerRadius = cornerRadius
        case .borderWidth(let borderWidth):
            self.borderWidth = borderWidth
        case .borderColor(let borderColor):
            self.borderColor = borderColor
        case .shadowStyle(let shadowStyle):
            self.shadowStyle = shadowStyle
        case .textStyle(let textStyle):
            self.textStyle = textStyle
        }
    }
}
