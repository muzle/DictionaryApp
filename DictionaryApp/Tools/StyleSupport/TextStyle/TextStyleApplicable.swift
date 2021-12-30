import UIKit

protocol TextStyleApplicable {
    func applyTextStyle(_ style: TextStyleType)
}

// MARK: - UILabel implement TextStyleApplicable

extension UILabel: TextStyleApplicable {
    func applyTextStyle(_ style: TextStyleType) {
        font = style.font
        textColor = style.color
        textAlignment = style.alignment
        numberOfLines = style.numberOfLines
    }
}

// MARK: - UITextField implement TextStyleApplicable

extension UITextField: TextStyleApplicable {
    func applyTextStyle(_ style: TextStyleType) {
        font = style.font
        textColor = style.color
        textAlignment = style.alignment
    }
}

// MARK: - UITextView implement TextStyleApplicable

extension UITextView: TextStyleApplicable {
    func applyTextStyle(_ style: TextStyleType) {
        font = style.font
        textColor = style.color
        textAlignment = style.alignment
    }
}

// MARK: - UIButton implement TextStyleApplicable

extension UIButton: TextStyleApplicable {
    func applyTextStyle(_ style: TextStyleType) {
        titleLabel?.font = style.font
        setTitleColor(style.color, for: [])
        switch style.alignment {
        case .left:
            contentHorizontalAlignment = .left
        case .center:
            contentHorizontalAlignment = .center
        case .right:
            contentHorizontalAlignment = .right
        case .justified:
            break
        case .natural:
            break
        @unknown default:
            break
        }
    }
}

// MARK: - NSAttributedString + TextStyleApplicable

extension NSAttributedString {
    convenience init(string: String, style: TextStyleType) {
        let alignmentStyle = NSMutableParagraphStyle().apply {
            $0.alignment = style.alignment
        }
        self.init(
            string: string,
            attributes: [
                .font: style.font,
                .foregroundColor: style.color,
                .paragraphStyle: alignmentStyle
            ]
        )
    }
}
