import Foundation

public protocol RouterType {
    associatedtype Event
    func handle(event: Event)
}
