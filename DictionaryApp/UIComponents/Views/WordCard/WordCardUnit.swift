import Foundation

enum WordCardUnit: UnitType {
    typealias Delegate = WordCardDelegate
    typealias Handler = WordCardPresenter
}

protocol WordCardPresenter {
    func didLoad()
    func willReuse()
    func getText() -> String?
    func getDescription() -> String?
}

final class WordCardPresenterImpl: PresenterType {
    typealias Unit = WordCardUnit
    typealias Delegate = Unit.Delegate
    typealias Context = HasWordsUseCase
    struct Configuration {
        let word: Word
    }
    
    private let context: Context
    private weak var delegate: Delegate?
    private let configuration: Configuration
    private let cancelableTracker = CancelableTracker()
    
    init(
        context: Context,
        configuration: Configuration
    ) {
        self.context = context
        self.configuration = configuration
    }
    
    func attach(delegate: Delegate) -> Unit.Handler {
        self.delegate = delegate
        delegate.setTitle(configuration.word.text)
        return self
    }
}

// MARK: - Implement WordMeaningPresenter

extension WordCardPresenterImpl: WordCardPresenter {
    func didLoad() {
        delegate?.setImage(Asset.ic60ImagePlaceholder.image)
        cancelableTracker += context.wordsUseCase.getImage(for: configuration.word) { [delegate] result in
            switch result {
            case .success(let image):
                delegate?.setImage(image ?? Asset.ic60ImagePlaceholder.image)
            case .failure:
                delegate?.setImage(Asset.ic60ImagePlaceholder.image)
            }
        }
    }
    func willReuse() {
        cancelableTracker.cancel()
    }
    func getText() -> String? {
        configuration.word.text.capitalizingFirstLetter()
    }
    
    func getDescription() -> String? {
        configuration.word.meanings
            .compactMap { $0.translation?.text }
            .joined(separator: ", ")
            .capitalizingFirstLetter()
    }
}
