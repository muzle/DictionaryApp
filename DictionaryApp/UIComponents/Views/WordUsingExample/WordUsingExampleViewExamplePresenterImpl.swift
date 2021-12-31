import Foundation

final class WordUsingExampleViewExamplePresenterImpl: PresenterType {
    typealias Unit = WordUsingExampleViewUnit
    typealias Delegate = Unit.Delegate
    typealias Context = HasWordsUseCase
    typealias Router = Unit.Router
    struct Configuration {
        let example: Example
    }
    
    private let context: Context
    private weak var delegate: Delegate?
    private let configuration: Configuration
    private let router: Router
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

extension WordUsingExampleViewExamplePresenterImpl: WordUsingExampleViewPresenter {
    func text() -> String? {
        configuration.example.text
    }
    func showSoundButton() -> Bool {
        context.wordsUseCase.canPlaySound(for: configuration.example)
    }
    
    func play() {
        do {
            cancelableTracker += try context.wordsUseCase.play(for: configuration.example)
        } catch {
            router.handle(event: .error(error))
        }
    }
    func textStyle() -> TextStyle {
        TextStyleFactory.SmallMessage.left
    }
}
