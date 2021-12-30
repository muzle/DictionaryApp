import Foundation

final class CancelableTracker: Cancelable {
    private var cancelables: [Cancelable?] = []
    
    deinit {
        cancelables.forEach {
            $0?.cancel()
        }
    }
    
    func add(_ cancelable: Cancelable?) {
        cancelables.append(cancelable)
    }
    
    func insert(_ cancelables: Cancelable...) {
        self.cancelables.append(contentsOf: cancelables)
    }
    
    func cancel() {
        cancelables.forEach {
            $0?.cancel()
        }
        cancelables = []
    }
}

// swiftlint:disable operator_whitespace
func +=(left: CancelableTracker, right: Cancelable?) {
    left.add(right)
}
// swiftlint:enable operator_whitespace
