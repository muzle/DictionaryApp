import Foundation
import UIKit

final class WordMeaningSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory & WordMeaningScenePresenterImpl.Context
    typealias Navigator = NavigatorType
    struct Configuration {
        let id: Int
    }
    
    private let context: Context
    private weak var navigation: Navigator?
    private let configuration: Configuration
    
    init(
        context: Context,
        navigation: Navigator?,
        configuration: Configuration
    ) {
        self.context = context
        self.navigation = navigation
        self.configuration = configuration
    }
}

// MARK: - Implement CoordinatorType

extension WordMeaningSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let config = WordMeaningScenePresenterImpl.Configuration(
            id: configuration.id
        )
        let scenePresenter = WordMeaningScenePresenterImpl(
            context: context,
            configuration: config,
            router: asRouter()
        )
        let scene = WordMeaningScene()
        let presenter = scenePresenter.attach(delegate: scene)
        scene.attach(presenter: presenter)
        return scene
    }
}

// MARK: - Implement RouterType

extension WordMeaningSceneCoordinator: RouterType {
    func handle(event: WordMeaningSceneUnit.Event) {
        switch event {
        case .meaning(let id):
            let config = WordMeaningSceneCoordinator.Configuration(
                id: id
            )
            let coordinator = context.makeWordMeaningSceneCoordinator(
                navigation: navigation,
                configuration: config
            )
            let scene = coordinator.makeScene()
            navigation?.push(scene, animated: true)
        case .alert(let block):
            navigation?.presentAlert(block: block)
        }
    }
}
