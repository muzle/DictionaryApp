import Foundation

enum InfoViewUnit: UnitType {
    enum Event {
        case tap
    }
    typealias Delegate = InfoViewDelegate
    typealias Handler = InfoViewPresenter
}

protocol InfoViewPresenter {
    func tap()
    func components() -> [InfoViewComponentType]
}

final class InfoViewPresenterImpl: PresenterType {
    typealias Unit = InfoViewUnit
    typealias Delegate = Unit.Delegate
    typealias Router = Unit.Router
    struct Configuration {
        let components: [InfoViewComponentType]
    }
    
    private weak var delegate: Delegate?
    private let configuration: Configuration
    private let router: Router
    
    init(
        configuration: Configuration,
        router: Router
    ) {
        self.configuration = configuration
        self.router = router
    }
    
    func attach(delegate: Delegate) -> Unit.Handler {
        self.delegate = delegate
        return self
    }
}

// MARK: - Implement WordMeaningPresenter

extension InfoViewPresenterImpl: InfoViewPresenter {
    func components() -> [InfoViewComponentType] {
        configuration.components
    }
    
    func tap() {
        router.handle(event: .tap)
    }
}
