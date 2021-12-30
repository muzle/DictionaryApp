import UIKit

extension UIViewController {
    private struct ObjectKey {
        static var preloaderView = "preloaderView"
    }
    
    // swiftlint:disable computed_accessors_order
    private var prelaoderView: UIView? {
        set { objc_setAssociatedObject(self, &ObjectKey.preloaderView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { objc_getAssociatedObject(self, &ObjectKey.preloaderView) as? UIView }
    }
    // swiftlint:enable computed_accessors_order
    
    func showPreloader(_ value: Bool) {
        showPreloader(in: view, value: value)
    }
    
    private func showPreloader(in view: UIView?, value: Bool) {
        if value {
            prelaoderView?.removeFromSuperview()
            guard let view = view else { return }
            var viewFrame = view.bounds == .zero ? UIScreen.main.bounds : view.bounds
            viewFrame = CGRect(
                origin: .zero,
                size: CGSize(
                    width: viewFrame.width - view.safeAreaInsets.hSum,
                    height: viewFrame.height - view.safeAreaInsets.vSum
                )
            )
            let preloaderView = PreloaderView(frame: viewFrame)
            if let tableViewController = self as? UITableViewController {
                tableViewController.view.addSubview(preloaderView)
            } else {
                view.addSubview(preloaderView)
                preloaderView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            }
            self.prelaoderView = preloaderView
        } else {
            prelaoderView?.removeFromSuperview()
            prelaoderView = nil
        }
    }
}
