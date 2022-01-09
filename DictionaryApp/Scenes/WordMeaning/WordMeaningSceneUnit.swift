import Foundation

enum WordMeaningSceneUnit: UnitType {
    enum Event {
        case meaning(Int)
        case alert(AlertConfigurationBlock)
    }
    typealias Delegate = WordMeaningSceneDelegate
    typealias Handler = WordMeaningScenePresenter
}

protocol WordMeaningScenePresenter {
    func didLoad()
    func playSound()
}

final class WordMeaningScenePresenterImpl: PresenterType {
    typealias Unit = WordMeaningSceneUnit
    typealias Delegate = Unit.Delegate
    typealias Router = Unit.Router
    typealias Context = HasWordsUseCase
    struct Configuration {
        let id: Int
    }
    
    private let context: Context
    private weak var delegate: Delegate?
    private let configuration: Configuration
    private let router: Router
    private var meaning: WordMeaning?
    private let cancelableTracker = CancelableTracker()
    
    init(
        context: Context,
        configuration: Configuration,
        router: Router
    ) {
        self.context = context
        self.configuration = configuration
        self.router = router
    }
    
    deinit {
        cancelableTracker.cancel()
    }
    
    func attach(delegate: Delegate) -> Unit.Handler {
        self.delegate = delegate
        return self
    }
}

// MARK: - Implement WordMeaningPresenter

extension WordMeaningScenePresenterImpl: WordMeaningScenePresenter {
    func didLoad() {
        delegate?.showPreloader(true)
        loadMeaning()
    }
    
    func playSound() {
        guard let meaning = meaning else { return }
        do {
            cancelableTracker += try context.wordsUseCase.play(for: meaning)
        } catch {
            let block = makeErrorAlertBlock(from: error)
            router.handle(event: .alert(block))
        }
    }
}

// MARK: - Helpers

private extension WordMeaningScenePresenterImpl {
    func loadMeaning() {
        delegate?.showInfoView(nil)
        delegate?.showPreloader(true)
        cancelableTracker += context.wordsUseCase.getWordMeanig(id: configuration.id) { [self] result in
            defer {
                delegate?.showPreloader(false)
            }
            switch result {
            case .success(let model):
                didLoadMeaning(model)
            case .failure(let error):
                let presenter = makeLoadErrorInfoPresenter(from: error)
                delegate?.showInfoView(presenter)
            }
        }
    }
    func didLoadMeaning(_ meaning: WordMeaning) {
        self.meaning = meaning
        delegate?.navigationTitle(meaning.text?.capitalizingFirstLetter())
        delegate?.setText(meaning.text?.uppercased())
        delegate?.setTranslate(meaning.translation?.text.capitalizingFirstLetter())
        delegate?.showSoundButton(context.wordsUseCase.canPlaySound(for: meaning))
        delegate?.setComponents(makeComponents())
        
        cancelableTracker += context.wordsUseCase.getImage(for: meaning) { [delegate] result in
            switch result {
            case .success(let image):
                delegate?.setImage(image ?? Asset.ic60ImagePlaceholder.image, updateConstraint: image != nil)
            case .failure:
                delegate?.setImage(Asset.ic60ImagePlaceholder.image, updateConstraint: false)
            }
        }
    }
    
    func makeComponents() -> [WordMeaningSceneComponentType] {
        var components = [WordMeaningSceneComponentType]()
        if let defintion = makeDefinitionPresenter() {
            components.append(.definition(defintion))
        }
        let examples = makeExamplePresenters()
        if !examples.isEmpty {
            components.append(.examples(examples))
        }
        let similarTranslations = makeSimilarTranslationPresenters()
        if !similarTranslations.isEmpty {
            components.append(.similarTranslations(similarTranslations))
        }
        return components
    }
    
    func makeDefinitionPresenter() -> WordUsingExampleViewUnit.Presenter? {
        guard let definition = meaning?.definition else { return nil }
        let presenter = WordUsingExampleViewDefinitionPresenterImpl(
            context: context,
            configuration: .init(definition: definition),
            router: makeWordUsingExampleViewRouter()
        )
        return presenter.asAnyPresenter()
    }
    func makeExamplePresenters() -> [WordUsingExampleViewUnit.Presenter] {
        guard let examples = meaning?.examples else { return [] }
        return examples.map(makeExamplePresenter(_:))
    }
    func makeExamplePresenter(_ example: Example) -> WordUsingExampleViewUnit.Presenter {
        let presenter = WordUsingExampleViewExamplePresenterImpl(
            context: context,
            configuration: .init(example: example),
            router: makeWordUsingExampleViewRouter()
        )
        return presenter.asAnyPresenter()
    }
    func makeSimilarTranslationPresenters() -> [AdditionalTranslateViewUnit.Presenter] {
        guard let translations = meaning?.meaningsWithSimilarTranslation else { return [] }
        return translations.map(makeSimilarTranslationPresenter(_:))
    }
    func makeSimilarTranslationPresenter(_ translation: MeaningsWithSimilarTranslation) -> AdditionalTranslateViewUnit.Presenter {
        let presenter = AdditionalTranslateViewPresenterImpl(
            context: context,
            configuration: .init(meaning: translation),
            router: .init({ [translation, router] event in
                switch event {
                case .tap:
                    router.handle(event: .meaning(translation.meaningId))
                }
            })
        )
        return presenter.asAnyPresenter()
    }
    
    func makeWordUsingExampleViewRouter() -> WordUsingExampleViewUnit.Router {
        WordUsingExampleViewUnit.Router { [self] event in
            switch event {
            case .error(let error):
                let block = makeErrorAlertBlock(from: error)
                router.handle(event: .alert(block))
            }
        }
    }
    private func makeErrorAlertBlock(from error: Error) -> AlertConfigurationBlock {
        let config = AlertConfiguration.makeOkErrorAlertConfiguration(message: error.localizedDescription)
        let block = AlertConfigurationBlock(alertConfiguration: config)
        return block
    }
    private func makeLoadErrorInfoPresenter(from error: Error) -> InfoViewUnit.Presenter {
        let config = InfoViewPresenterImpl.Configuration(
            components: [
                .text(
                    message: GSln.InfoView.errorHeader,
                    style: TextStyleFactory.Info.headerCenter
                ),
                .text(
                    message: error.localizedDescription,
                    style: TextStyleFactory.Info.messageCenter
                ),
                .button(GSln.InfoView.buttonRepeat)
            ]
        )
        let presenter = InfoViewPresenterImpl(
            configuration: config,
            router: .init({ [self] event in
                switch event {
                case .tap:
                    loadMeaning()
                }
            })
        )
        return presenter.asAnyPresenter()
    }
}
