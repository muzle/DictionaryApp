import Foundation

private struct Constants {
    let email = "evgrud@icloud.com"
    let tlg = "voragomod"
}
private let constants = Constants()

enum WelcomeSceneUnit: UnitType {
    enum Event {
        case alert(AlertConfigurationBlock)
    }
    typealias Delegate = WelcomeSceneDelegate
    typealias Handler = WelcomeScenePresenter
}

protocol WelcomeScenePresenter {
    func emailTap()
    func telegramTap()
}

final class WelcomeScenePresenterImpl: PresenterType {
    typealias Unit = WelcomeSceneUnit
    typealias Delegate = Unit.Delegate
    typealias Router = Unit.Router
    typealias Context = HasSocialService
    
    private let context: Context
    private weak var delegate: Delegate?
    private let router: Router
    
    init(
        context: Context,
        router: Router
    ) {
        self.context = context
        self.router = router
    }
    
    func attach(delegate: Delegate) -> Unit.Handler {
        self.delegate = delegate
        return self
    }
}

// MARK: - Implement WelcomePresenter

extension WelcomeScenePresenterImpl: WelcomeScenePresenter {
    func emailTap() {
        do {
            try context.socialService.openEmail(email: constants.email)
        } catch {
            let block = makeErrorAlertBlock(error: error)
            router.handle(event: .alert(block))
        }
    }
    
    func telegramTap() {
        do {
            try context.socialService.openTelegram(login: constants.tlg)
        } catch {
            let block = makeErrorAlertBlock(error: error)
            router.handle(event: .alert(block))
        }
    }
}

// MARK: - Helpers

private extension WelcomeScenePresenterImpl {
    func makeErrorAlertBlock(error: Error) -> AlertConfigurationBlock {
        let config = AlertConfiguration.makeOkErrorAlertConfiguration(message: error.localizedDescription)
        let block = AlertConfigurationBlock(alertConfiguration: config)
        return block
    }
}
