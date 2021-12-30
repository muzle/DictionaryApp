import class Foundation.NSObject

public protocol ClassNameType {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameType {
    static var className: String {
        String(describing: self)
    }

    var className: String {
        type(of: self).className
    }
}

// MARK: - NSObject implement ClassNameType

extension NSObject: ClassNameType { }
