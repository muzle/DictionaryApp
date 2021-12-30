import UIKit

extension UIControl {
    private final class ClosureWrapper {
        let closure: () -> Void
        
        init(_ closure: @escaping () -> Void) {
            self.closure = closure
        }
        
        @objc func invoke() { closure() }
    }
    
    func addTarget(
        for controlEvents: UIControl.Event,
        closure: @escaping () -> Void
    ) {
        let wrapper = ClosureWrapper(closure)
        addTarget(wrapper, action: #selector(wrapper.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", wrapper, .OBJC_ASSOCIATION_RETAIN)
    }
}
