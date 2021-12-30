import Foundation

public protocol UnitType {
    associatedtype Event = Never
    associatedtype Delegate
    associatedtype Handler
}

public extension UnitType {
    typealias Presenter = AnyPresenter<Delegate, Handler>
    typealias Router = AnyRouter<Event>
}
