import Foundation

public final class AnyPresenter<Delegate, Handler>: PresenterType {
    private let attach_: (Delegate) -> Handler
    
    public init<Presenter: PresenterType>(_ presenter: Presenter) where Presenter.Delegate == Delegate, Presenter.Handler == Handler {
        attach_ = presenter.attach
    }
    
    public func attach(delegate: Delegate) -> Handler {
        attach_(delegate)
    }
}
