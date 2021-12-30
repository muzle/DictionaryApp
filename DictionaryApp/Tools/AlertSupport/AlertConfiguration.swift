import Foundation

struct AlertConfiguration {
    let title: String?
    let message: String?
    let actions: [String]
    let cancel: String?
    let style: AlertStyle
    let position: AlertPosition
    
    init(
        title: String? = nil,
        message: String? = nil,
        actions: [String],
        cancel: String? = nil,
        style: AlertStyle = .base,
        position: AlertPosition = .bottom
    ) {
        self.title = title
        self.message = message
        self.actions = actions
        self.cancel = cancel
        self.style = style
        self.position = position
    }
    
    init(
        title: String? = nil,
        message: String? = nil,
        action: String? = nil,
        cancel: String? = nil,
        style: AlertStyle = .base,
        position: AlertPosition = .bottom
    ) {
        self.title = title
        self.message = message
        self.actions = action == nil ? [] : [action!]
        self.cancel = cancel
        self.style = style
        self.position = position
    }
}
