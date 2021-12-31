import Foundation

enum AdditionalTranslateViewUnit: UnitType {
    enum Event {
        case tap
    }
    typealias Delegate = AdditionalTranslateViewDelegate
    typealias Handler = AdditionalTranslateViewPresenter
}

protocol AdditionalTranslateViewPresenter {
    func text() -> String?
    func note() -> String?
    func tap()
}

final class AdditionalTranslateViewPresenterImpl: PresenterType {
    typealias Unit = AdditionalTranslateViewUnit
    typealias Delegate = Unit.Delegate
    typealias Context = HasWordsUseCase
    typealias Router = Unit.Router
    struct Configuration {
        let meaning: MeaningsWithSimilarTranslation
    }
    
    private let context: Context
    private weak var delegate: Delegate?
    private let configuration: Configuration
    private let router: Router
    
    init(
        context: Context,
        configuration: Configuration,
        router: Router
    ) {
        self.context = context
        self.configuration = configuration
        self.router = router
    }
    
    func attach(delegate: Delegate) -> Unit.Handler {
        self.delegate = delegate
        return self
    }
}

// MARK: - Implement WordMeaningPresenter

extension AdditionalTranslateViewPresenterImpl: AdditionalTranslateViewPresenter {
    func text() -> String? {
        configuration.meaning.translation?.text.capitalizingFirstLetter()
    }
    
    func note() -> String? {
        configuration.meaning.translation?.note
    }
    
    func tap() {
        router.handle(event: .tap)
    }
}

// MARK: - Helpers

private extension AdditionalTranslateViewPresenterImpl {
    
}
