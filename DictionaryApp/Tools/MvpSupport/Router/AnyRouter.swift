import Foundation

public final class AnyRouter<Event>: RouterType {
    private let completion: (Event) -> Void
    
    public init(_ completion: @escaping (Event) -> Void) {
        self.completion = completion
    }
    
    public init<Router: RouterType>(_ router: Router) where Router.Event == Event {
        completion = router.handle(event:)
    }
    
    public func handle(event: Event) {
        completion(event)
    }
}
