import Foundation

// swiftlint:disable type_name
final class WordUsingExampleViewDefinitionPresenterImpl: PresenterType {
    typealias Unit = WordUsingExampleViewUnit
    typealias Delegate = Unit.Delegate
    typealias Context = HasWordsUseCase
    typealias Router = Unit.Router
    struct Configuration {
        let definition: Definition
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

extension WordUsingExampleViewDefinitionPresenterImpl: WordUsingExampleViewPresenter {
    func text() -> String? {
        configuration.definition.text
    }
    func showSoundButton() -> Bool {
        false
    }
    func play() {
        
    }
    func textStyle() -> TextStyle {
        TextStyleFactory.Message.leftMedium
    }
}
// swiftlint:enable type_name
