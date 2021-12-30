import Foundation
import UIKit
import SnapKit

private struct Constants {
    let labelsStackViewSpacing = CGFloat(4)
    let labelsStackViewContentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let imageViewHeightMultiplier = CGFloat(96.0/72.0)
}
private let constants = Constants()

final class WordCard: UIView {
    typealias Unit = WordCardUnit
    typealias Presenter = Unit.Handler
    private var presenter: Presenter!
    
    private let imageView = UIImageView()
    private let label = UILabel()
    private let descriptionLabel = UILabel()
    
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

private extension WordCard {
    func commonInit() {
        setConstraints()
        applyStyle()
    }
    
    func setConstraints() {
        let labelsStackView = UIStackView(arrangedSubviews: [label, descriptionLabel]).apply {
            $0.axis = .vertical
            $0.spacing = constants.labelsStackViewSpacing
        }
        [imageView, labelsStackView].forEach(addSubview(_:))
        imageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(imageView.snp.height).multipliedBy(constants.imageViewHeightMultiplier)
        }
        labelsStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(constants.labelsStackViewContentInset.left)
            $0.centerY.equalToSuperview()
            $0.top.greaterThanOrEqualToSuperview().offset(constants.labelsStackViewContentInset.top)
            $0.bottom.lessThanOrEqualToSuperview().offset(constants.labelsStackViewContentInset.bottom)
            $0.trailing.equalToSuperview().inset(constants.labelsStackViewContentInset)
        }
    }
    
    func applyStyle() {
        applyViewStyle(ViewStyleFatory.View.wordCard)
        label.applyTextStyle(TextStyleFactory.Message.left)
        descriptionLabel.applyTextStyle(TextStyleFactory.SmallMessage.left)
    }
}

// MARK: - Implement WordCardDelegate

extension WordCard: WordCardDelegate {
    func setTitle(_ text: String?) {
        label.text = text
    }
    
    func setDescription(_ text: String?) {
        descriptionLabel.text = text
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}

// MARK: - Implement PresenterAttachable

extension WordCard: PresenterAttachable {
    func attach(presenter: Presenter) {
        self.presenter = presenter
        presenter.didLoad()
        setTitle(presenter.getText())
        setDescription(presenter.getDescription())
    }
}

// MARK: - Implement Reusable

extension WordCard: Reusable {
    func reuse() {
        presenter.willReuse()
    }
}
