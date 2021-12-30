import Foundation

enum SearchWordSceneUnit: UnitType {
    enum Event {
        case meaning(Int)
    }
    typealias Delegate = SearchWordSceneDelegate
    typealias Handler = SearchWordScenePresenter & SearchResultScenePresenter
}

protocol SearchWordScenePresenter {
    func didLoad()
    func didSelectIten(index: Int, section: Int)
}

final class SearchWordScenePresenterImpl: PresenterType {
    typealias Unit = SearchWordSceneUnit
    typealias Delegate = Unit.Delegate
    typealias Router = Unit.Router
    typealias Context = HasWordsUseCase
    struct Configuration {
        let searhText: String?
        let searchResultScenePresenterWrapper: ReferenceWrapper<(() -> SearchResultScenePresenter)?>
    }
    
    private let context: Context
    private weak var delegate: Delegate?
    private let configuration: Configuration
    private let router: Router
    private lazy var debouncer = Debouncer()
    private var loadedWords = [Word]()
    private var searchText = ""
    
    init(
        context: Context,
        configuration: Configuration,
        router: Router
    ) {
        self.context = context
        self.configuration = configuration
        self.router = router
        configuration.searchResultScenePresenterWrapper.value = { self }
    }
    
    func attach(delegate: Delegate) -> Unit.Handler {
        self.delegate = delegate
        return self
    }
}

// MARK: - Implement SearchWordPresenter

extension SearchWordScenePresenterImpl: SearchWordScenePresenter {
    func didSelectIten(index: Int, section: Int) {
        let word = loadedWords[index]
        router.handle(event: .meaning(word.meanings[safe: 0]!.id))
    }
}

// MARK: - Implement SearchResultScenePresenter

extension SearchWordScenePresenterImpl: SearchResultScenePresenter {
    func didLoad() {
        if let text = configuration.searhText, !text.isEmpty {
            searchTextDidChange(text: text)
        } else {
            delegate?.showInfoView(makeEmtySearchTextInfoPresenter())
        }
    }
    
    func cancelButtonTap() {
        loadedWords = []
        delegate?.udpate(dataSource: [])
        searchText = ""
        delegate?.showInfoView(makeEmtySearchTextInfoPresenter())
    }
    
    func searchTextDidChange(text: String) {
        searchText = text
        if text.isEmpty {
            loadedWords = []
            delegate?.udpate(dataSource: [])
            delegate?.showInfoView(makeEmtySearchTextInfoPresenter())
            return
        }
        delegate?.showPreloader(true)
        debouncer.debounce(timeInterval: .milliseconds(400), queue: .global(qos: .userInitiated)) { [self, text] in
            guard !text.isEmpty else { return }
            context.wordsUseCase.findWords(with: text) { [self] result in
                DispatchQueue.main.async {
                    defer { delegate?.showPreloader(false) }
                    switch result {
                    case .success(let words):
                        delegate?.showInfoView(words.isEmpty ? makeEmtySearchResultInfoPresenter() : nil)
                        didLoadWords(words)
                    case .failure(let error):
                        didLoadWords([])
                        let presenter = makeErrorInfoPresenter(for: error)
                        delegate?.showInfoView(presenter)
                    }
                }
            }
        }
    }
}

// MARK: - Helpers

private extension SearchWordScenePresenterImpl {
    private func didLoadWords(_ words: [Word]) {
        self.loadedWords = words
        let dataSource = words.map(makeCellModel(for:))
        delegate?.udpate(dataSource: dataSource)
    }
    
    private func makeCellModel(for word: Word) -> WordCardUnit.Presenter {
        WordCardPresenterImpl(
            context: context,
            configuration: .init(word: word)
        ).asAnyPresenter()
    }
    
    private func makeEmtySearchTextInfoPresenter() -> InfoViewUnit.Presenter {
        let config = InfoViewPresenterImpl.Configuration(
            components: [
                .image(Asset.ic80Mark.image),
                .text(message: GSln.InfoView.needInputWord, style: TextStyleFactory.Info.messageCenter)
            ]
        )
        let presenter = InfoViewPresenterImpl(
            configuration: config,
            router: makeEmtySearchTextInfoPresenterRouter()
        )
        return presenter.asAnyPresenter()
    }
    private func makeEmtySearchResultInfoPresenter() -> InfoViewUnit.Presenter {
        let config = InfoViewPresenterImpl.Configuration(
            components: [
                .image(Asset.ic80Search.image),
                .text(message: GSln.InfoView.wordNotFined, style: TextStyleFactory.Info.messageCenter)
            ]
        )
        let presenter = InfoViewPresenterImpl(
            configuration: config,
            router: makeEmtySearchTextInfoPresenterRouter()
        )
        return presenter.asAnyPresenter()
    }
    private func makeErrorInfoPresenter(for error: Error) -> InfoViewUnit.Presenter {
        let config = InfoViewPresenterImpl.Configuration(
            components: [
                .text(message: GSln.InfoView.errorHeader, style: TextStyleFactory.Info.headerCenter),
                .text(message: error.localizedDescription, style: TextStyleFactory.Info.messageCenter),
                .button(GSln.InfoView.buttonRepeat)
            ]
        )
        let presenter = InfoViewPresenterImpl(
            configuration: config,
            router: makeEmtySearchTextInfoPresenterRouter()
        )
        return presenter.asAnyPresenter()
    }
    
    private func makeEmtySearchTextInfoPresenterRouter() -> InfoViewUnit.Router {
        InfoViewUnit.Router { [self] event in
            switch event {
            case .tap:
                searchTextDidChange(text: searchText)
            }
        }
    }
}
