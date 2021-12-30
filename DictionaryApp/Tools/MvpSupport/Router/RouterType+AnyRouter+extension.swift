import Foundation

public extension RouterType {
    func asRouter() -> AnyRouter<Event> {
        AnyRouter<Event>(self)
    }
}
