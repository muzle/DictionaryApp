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
        let searchResultScenePresenterWrapper = ReferenceWrapper<(() -> SearchResultScenePresenter)?>(value: nil)
        let searchResultCoordinatorConfig = SearchWordSceneCoordinator.Configuration(
            searchText: nil,
            searchResultScenePresenterWrapper: searchResultScenePresenterWrapper
        )
        let searchResultCoordinator = context.makeSearchWordSceneCoordinator(
            navigation: navigation,
            configuration: searchResultCoordinatorConfig
        )
        let searchResultScene = searchResultCoordinator.makeScene()
        guard let searchResultScenePresenter = searchResultScenePresenterWrapper.value?() else {
            preconditionFailure("Error get SearchResultScenePresenter")
        }
        let searchSceneCoordinatorConfig = SearchSceneCoordinator.Configuration(
            resultScene: searchResultScene,
            resultScenePresenter: searchResultScenePresenter,
            startText: nil,
            searchBarActivePlaceholder: GSln.WelcomeScene.activeSearchTitle,
            searchBarInactivePlaceholder: GSln.WelcomeScene.inactiveSearchTitle
        )
        let searchCoordinator = context.makeSearchSceneCoordinator(
            configuration: searchSceneCoordinatorConfig
        )
        guard let searchController = searchCoordinator.makeScene() as? UISearchController else {
            preconditionFailure("Error cast SearchSceneCoordinator scene to UISearchController")
        }
        let scenePresenter = WelcomeScenePresenterImpl(
            context: context,
            router: asRouter()
        )
        let scene = WelcomeScene().apply {
            $0.navigationItem.searchController = searchController
        }
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
