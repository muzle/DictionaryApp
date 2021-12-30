import Foundation
import UIKit

final class SearchWordSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory & SearchWordScenePresenterImpl.Context
    typealias Navigator = NavigatorType
    struct Configuration {
        let searchText: String?
        let searchResultScenePresenterWrapper: ReferenceWrapper<(() -> SearchResultScenePresenter)?>
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

extension SearchWordSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let config = SearchWordScenePresenterImpl.Configuration(
            searhText: configuration.searchText,
            searchResultScenePresenterWrapper: configuration.searchResultScenePresenterWrapper
        )
        let scenePresenter = SearchWordScenePresenterImpl(
            context: context,
            configuration: config,
            router: asRouter()
        )
        let scene = SearchWordScene()
        let presenter = scenePresenter.attach(delegate: scene)
        scene.attach(presenter: presenter)
        return scene
    }
}

// MARK: - Implement RouterType

extension SearchWordSceneCoordinator: RouterType {
    func handle(event: SearchWordSceneUnit.Event) {
        switch event {
        case .meaning(let id):
            print("ID: ", id)
        }
    }
}
