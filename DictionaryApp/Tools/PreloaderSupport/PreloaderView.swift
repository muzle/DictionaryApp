import UIKit

final class PreloaderView: UIView {
    let activityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - Common init

private extension PreloaderView {
    func commonInit() {
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        activityIndicatorView.startAnimating()
        applyViewStyle(ViewStyleFatory.View.commonSceneBackground)
    }
}
