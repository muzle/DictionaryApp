import UIKit

final class SearchScene: UISearchController {
    typealias Unit = SearchSceneUnit
    typealias Presenter = Unit.Handler
    
    private var presenter: Presenter!
}

// MARK: - Life cycle

extension SearchScene {
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            preconditionFailure("presenter must be assigned before viewDidLoad")
        }
        commonInit()
    }
}

// MARK: - Implement SearchSceneDelegate

extension SearchScene: SearchSceneDelegate {
    func searchBarPlaceholder(_ placeholder: String?) {
        searchBar.placeholder = placeholder
    }
    func searchText(_ text: String?) {
        searchBar.text = text
    }
}

// MARK: - Implement PresenterAttachable

extension SearchScene: PresenterAttachable {
    func attach(presenter: Unit.Handler) {
        self.presenter = presenter
    }
}

// MARK: - Common init

private extension SearchScene {
    func commonInit() {
        searchBar.delegate = self
        if #available(iOS 13.0, *) {
            showsSearchResultsController = true
        }
    }
}

// MARK: - Implement UISearchBarDelegate

extension SearchScene: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presenter.startSearch()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter.finishSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.complete()
    }
    
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        presenter.textChanged(text: searchText)
    }
}
