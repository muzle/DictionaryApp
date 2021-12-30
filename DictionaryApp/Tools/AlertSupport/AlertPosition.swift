import class UIKit.UIAlertController

enum AlertPosition {
    case midle, bottom
}

extension UIAlertController.Style {
    init(from position: AlertPosition) {
        switch position {
        case .midle:
            self = .alert
        case .bottom:
            self = .actionSheet
        }
    }
}
