import Foundation

public protocol PresenterType {
    associatedtype Unit: UnitType = SimpleUnit<Delegate, Handler, Never> where Unit.Delegate == Delegate, Unit.Handler == Handler
    associatedtype Delegate
    associatedtype Handler
    
    func attach(delegate: Delegate) -> Handler
}

extension PresenterType {
    func asAnyPresenter() -> AnyPresenter<Delegate, Handler> {
        AnyPresenter<Delegate, Handler>(self)
    }
}
