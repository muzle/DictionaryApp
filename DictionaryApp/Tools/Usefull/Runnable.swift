import class Foundation.NSObject

public protocol Runnable {}

public extension Runnable {
    @discardableResult
    func run<T>(closure: (Self) -> T) -> T {
        return closure(self)
    }
}

// MARK: - NSObject implement Runnable

extension NSObject: Runnable { }
