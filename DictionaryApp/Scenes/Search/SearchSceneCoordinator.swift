import Foundation
import UIKit

final class SearchSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory & SearchScenePresenterImpl.Context
    struct Configuration {
        let resultScene: UIViewController
        let resultScenePresenter: SearchResultScenePresenter
        let startText: String?
        let searchBarActivePlaceholder: String?
        let searchBarInactivePlaceholder: String?
    }
    
    private let context: Context
    private let configuration: Configuration
    
    init(
        context: Context,
        configuration: Configuration
    ) {
        self.context = context
        self.configuration = configuration
    }
}

// MARK: - Implement CoordinatorType

extension SearchSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let config = SearchScenePresenterImpl.Configuration(
            searchResultScenePresenter: configuration.resultScenePresenter,
            searchBarActivePlaceholder: configuration.searchBarActivePlaceholder,
            searchBarInactivePlaceholder: configuration.searchBarInactivePlaceholder
        )
        let scenePresenter = SearchScenePresenterImpl(
            context: context,
            configuration: config
        )
        let scene = SearchScene(searchResultsController: configuration.resultScene).apply {
            $0.searchBar.placeholder = configuration.searchBarInactivePlaceholder
            $0.searchBar.text = configuration.startText
        }
        let presenter = scenePresenter.attach(delegate: scene)
        scene.attach(presenter: presenter)
        return scene
    }
}
