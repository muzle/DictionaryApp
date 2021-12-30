import UIKit

final class WelcomeScene: UIViewController {
    typealias Unit = WelcomeSceneUnit
    typealias Presenter = Unit.Handler
    typealias ContentView = WelcomeSceneView
    
    private var presenter: Presenter!
    private lazy var contentView = ContentView()
}

// MARK: - Life cycle

extension WelcomeScene {
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            preconditionFailure("presenter must be assigned before viewDidLoad")
        }
        commonInit()
    }
}

// MARK: - Implement WelcomeSceneDelegate

extension WelcomeScene: WelcomeSceneDelegate {
    
}

// MARK: - Implement PresenterAttachable

extension WelcomeScene: PresenterAttachable {
    func attach(presenter: Unit.Handler) {
        self.presenter = presenter
    }
}

// MARK: - Common init

private extension WelcomeScene {
    func commonInit() {
        navigationItem.title = GSln.WelcomeScene.navigationTitle
        registerActions()
    }
    
    func registerActions() {
        contentView.emailButton.addTarget(self, action: #selector(emailButtonDidTap(_:)), for: .touchUpInside)
        contentView.telegramButton.addTarget(self, action: #selector(telegramButtonDidTap(_:)), for: .touchUpInside)
    }
    
    @objc func emailButtonDidTap(_ sender: UIControl) {
        presenter.emailTap()
    }
    @objc func telegramButtonDidTap(_ sender: UIControl) {
        presenter.telegramTap()
    }
}
