import class Foundation.NSObject

public protocol Applicable { }

public extension Applicable {
    @discardableResult
    func apply(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

// MARK: - NSObject implement Applicable

extension NSObject: Applicable { }
