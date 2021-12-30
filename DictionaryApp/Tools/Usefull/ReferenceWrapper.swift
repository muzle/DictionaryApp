import Foundation

final class ReferenceWrapper<T> {
    var value: T
    
    init(value: T) {
        self.value = value
    }
}
