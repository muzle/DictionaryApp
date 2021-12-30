import Foundation

final class Debouncer: Cancelable {
    private var task: DispatchWorkItem?
    
    @discardableResult
    func debounce(
        timeInterval: DispatchTimeInterval,
        queue: DispatchQueue = .global(qos: .userInitiated),
        completion: @escaping () -> Void
    ) -> Cancelable {
        task?.cancel()
        let task = DispatchWorkItem(block: completion)
        self.task = task
        queue.asyncAfter(deadline: .now() + timeInterval, execute: task)
        return task
    }
    
    func cancel() {
        task?.cancel()
    }
}
