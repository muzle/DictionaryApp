import Foundation

enum SearchSceneUnit: UnitType {
    typealias Delegate = SearchSceneDelegate
    typealias Handler = SearchScenePresenter
}

protocol SearchScenePresenter {
    func startSearch()
    func finishSearch()
    func complete()
    func textChanged(text: String)
}

final class SearchScenePresenterImpl: PresenterType {
    typealias Unit = SearchSceneUnit
    typealias Delegate = Unit.Delegate
    typealias Context = NoContext
    struct Configuration {
        let searchResultScenePresenter: SearchResultScenePresenter
        let searchBarActivePlaceholder: String?
        let searchBarInactivePlaceholder: String?
        let completeTitle: String? = nil
    }
    
    private let context: Context
    private weak var delegate: Delegate?
    private let configuration: Configuration
    
    init(
        context: Context,
        configuration: Configuration
    ) {
        self.context = context
        self.configuration = configuration
    }
    
    func attach(delegate: Delegate) -> Unit.Handler {
        self.delegate = delegate
        return self
    }
}

// MARK: - Implement SearchPresenter

extension SearchScenePresenterImpl: SearchScenePresenter {
    func startSearch() {
        delegate?.searchBarPlaceholder(configuration.searchBarActivePlaceholder)
    }
    
    func finishSearch() {
        delegate?.searchBarPlaceholder(configuration.searchBarInactivePlaceholder)
    }
    
    func complete() {
        configuration.searchResultScenePresenter.cancelButtonTap?()
    }
    
    func textChanged(text: String) {
        configuration.searchResultScenePresenter.searchTextDidChange?(text: text)
    }
}
