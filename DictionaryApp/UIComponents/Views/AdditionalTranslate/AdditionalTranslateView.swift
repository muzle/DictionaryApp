import UIKit

private struct Constants {
    let stackViewSpacing = CGFloat(4)
    let stackViewTrailng = CGFloat(8)
    let contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let imageViewSize = CGSize(width: 24, height: 24)
}
private let constants = Constants()

final class AdditionalTranslateView: UIView {
    typealias Unit = AdditionalTranslateViewUnit
    typealias Presenter = Unit.Handler
    private var presenter: Presenter!
    
    private let label = UILabel()
    private let noteLabel = UILabel()
    private let imageView = UIImageView()
    
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

private extension AdditionalTranslateView {
    func commonInit() {
        setConstraints()
        setUI()
        applyStyle()
        registerActions()
    }
    
    func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [label, noteLabel]).apply {
            $0.axis = .vertical
            $0.spacing = constants.stackViewSpacing
        }
        [stackView, imageView].forEach(addSubview(_:))
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(constants.contentInset)
            $0.top.greaterThanOrEqualToSuperview().offset(constants.contentInset.top)
            $0.size.equalTo(constants.imageViewSize)
        }
        stackView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(constants.contentInset)
            $0.trailing.equalTo(imageView.snp.leading).offset(-constants.stackViewTrailng)
        }
    }
    
    func setUI() {
        imageView.image = Asset.ic24ChevronRight.image.setImageColor(color: Asset.commonIconColor.color)
    }
    
    func applyStyle() {
        applyViewStyle(ViewStyleFatory.View.wordCard)
        label.applyTextStyle(TextStyleFactory.Message.leftMedium)
        noteLabel.applyTextStyle(TextStyleFactory.SmallMessage.left)
    }
    
    func registerActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        presenter.tap()
    }
}

// MARK: - Implement AdditionalTranslateViewDelegate

extension AdditionalTranslateView: AdditionalTranslateViewDelegate {
    func setText(_ text: String?) {
        label.text = text
    }
    func setNote(_ text: String?) {
        noteLabel.run {
            $0.text = text
            $0.isHidden = text?.isEmpty != false
        }
    }
}

// MARK: - Implement PresenterAttachable

extension AdditionalTranslateView: PresenterAttachable {
    func attach(presenter: Presenter) {
        self.presenter = presenter
        setText(presenter.text())
        setNote(presenter.note())
    }
}
