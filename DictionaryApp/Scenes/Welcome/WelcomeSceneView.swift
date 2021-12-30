import UIKit
import SnapKit

private struct Constants {
    let buttonsStackViewSpacing = CGFloat(16)
    let messageLabelHInset = CGFloat(16)
    let buttonsStackViewInset = UIEdgeInsets(top: 36, left: 16, bottom: 16, right: 16)
}
private let constants = Constants()

final class WelcomeSceneView: UIView {
    let messageLabel = UILabel()
    let emailButton = UIButton()
    let telegramButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - CommonInit

private extension WelcomeSceneView {
    func commonInit() {
        setConstraints()
        localize()
        applyStyle()
    }
    
    func setConstraints() {
        let buttons = [emailButton, telegramButton]
        let buttonsStackView = UIStackView(arrangedSubviews: buttons).apply {
            $0.axis = .vertical
            $0.spacing = constants.buttonsStackViewSpacing
        }
        
        [messageLabel, buttonsStackView].forEach(addSubview(_:))
        
        messageLabel.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.centerY.equalTo(safeAreaLayoutGuide).priority(.medium)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(constants.messageLabelHInset)
            $0.bottom.lessThanOrEqualTo(buttonsStackView.snp.top).inset(-constants.buttonsStackViewInset.top)
        }
        buttonsStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(constants.buttonsStackViewInset)
        }
        buttons.forEach {
            $0.heightAnchor.constraint(equalToConstant: ButtonHeightFactory.mainButtonHeight).isActive = true
        }
    }
    
    func localize() {
        messageLabel.text = GSln.WelcomeScene.message
        emailButton.setTitle(GSln.WelcomeScene.emailButton, for: [])
        telegramButton.setTitle(GSln.WelcomeScene.telegramButton, for: [])
    }
    
    func applyStyle() {
        applyViewStyle(ViewStyleFatory.View.commonSceneBackground)
        messageLabel.applyTextStyle(TextStyleFactory.Message.center)
        emailButton.applyViewStyle(ViewStyleFatory.Button.main)
        telegramButton.applyViewStyle(ViewStyleFatory.Button.main)
    }
}
