import Foundation

final class AlertConfigurationBlock {
    let alertConfiguration: AlertConfiguration
    let interval: Int?
    let actionCompletion: (() -> Void)?
    let actionIdCompletion: ((Int) -> Void)?
    let cancel: (() -> Void)?
    let presented: (() -> Void)?
    let dissmissed: (() -> Void)?
    
    init(
        alertConfiguration: AlertConfiguration,
        interval: Int? = nil,
        actionCompletion: (() -> Void)? = nil,
        actionIdCompletion: ((Int) -> Void)? = nil,
        cancel: (() -> Void)? = nil,
        presented: (() -> Void)? = nil,
        dissmissed: (() -> Void)? = nil
    ) {
        self.alertConfiguration = alertConfiguration
        self.interval = interval
        self.actionCompletion = actionCompletion
        self.actionIdCompletion = actionIdCompletion
        self.cancel = cancel
        self.presented = presented
        self.dissmissed = dissmissed
    }
}
