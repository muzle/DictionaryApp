import UIKit

private struct Constants {
    let contentInset = UIEdgeInsets.zero
}
private let constants = Constants()

final class ViewWrapper<View: UIView>: UIView {
    let wrappedView: View
    var inset: UIEdgeInsets {
        willSet {
            guard newValue != inset else { return }
            wrappedView.snp.remakeConstraints { $0.edges.equalToSuperview().inset(newValue) }
        }
    }
    
    init(view: View, frame: CGRect = .zero, inset: UIEdgeInsets = constants.contentInset) {
        self.wrappedView = view
        self.inset = inset
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func commonInit() {
        addSubview(wrappedView)
        wrappedView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(inset)
        }
    }
    
    override func setContentCompressionResistancePriority(
        _ priority: UILayoutPriority,
        for axis: NSLayoutConstraint.Axis
    ) {
        super.setContentCompressionResistancePriority(
            priority,
            for: axis
        )
        wrappedView.setContentCompressionResistancePriority(
            priority,
            for: axis
        )
    }
}
