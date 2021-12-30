import UIKit

extension UIViewController {
    private struct ObjectKey {
        static var infoView = "infoView"
    }
    
    // swiftlint:disable computed_accessors_order
    private var infoView: InfoView? {
        set { objc_setAssociatedObject(self, &ObjectKey.infoView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { objc_getAssociatedObject(self, &ObjectKey.infoView) as? InfoView }
    }
    // swiftlint:enable computed_accessors_order
    
    func showInfoView(_ presenter: InfoViewUnit.Presenter?) {
        if let presenter = presenter {
            let infoView = infoView ?? makeInfoView(in: view)
            let handler = presenter.attach(delegate: infoView)
            infoView.attach(presenter: handler)
        } else {
            infoView?.removeFromSuperview()
            infoView = nil
        }
    }
    
    @discardableResult
    private func makeInfoView(in view: UIView) -> InfoView {
        var viewFrame = view.bounds == .zero ? UIScreen.main.bounds : view.bounds
        viewFrame = CGRect(
            origin: .zero,
            size: CGSize(
                width: viewFrame.width - view.safeAreaInsets.hSum,
                height: viewFrame.height - view.safeAreaInsets.vSum
            )
        )
        let infoView = InfoView(frame: viewFrame)
        if let tableViewController = self as? UITableViewController {
            tableViewController.view.addSubview(infoView)
        } else {
            view.addSubview(infoView)
            infoView.snp.makeConstraints {
                $0.edges.equalTo(view.safeAreaInsets)
            }
        }
        self.infoView = infoView
        return infoView
    }
}
