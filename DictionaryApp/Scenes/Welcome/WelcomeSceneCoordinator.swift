import Foundation
import UIKit

final class WelcomeSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory & WelcomeScenePresenterImpl.Context
    typealias Navigator = NavigatorType
    
    private let context: Context
    private weak var navigation: Navigator?
    
    init(
        context: Context,
        navigation: Navigator?
    ) {
        self.context = context
        self.navigation = navigation
    }
}

// MARK: - Implement CoordinatorType

extension WelcomeSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let scenePresenter = WelcomeScenePresenterImpl(
            context: context,
            router: asRouter()
        )
        let scene = WelcomeScene()
        let presenter = scenePresenter.attach(delegate: scene)
        scene.attach(presenter: presenter)
        return scene
    }
}

// MARK: - Implement RouterType

extension WelcomeSceneCoordinator: RouterType {
    func handle(event: WelcomeSceneUnit.Event) {
        switch event {
        case .alert(let block):
            navigation?.presentAlert(block: block)
        }
    }
}
