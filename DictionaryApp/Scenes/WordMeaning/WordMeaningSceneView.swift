import UIKit
import SnapKit

private struct Constants {
    let imageViewContentInset = UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
    let imageViewHeightMultiplier = 150.0/200.0
    let textStackViewSpacing = CGFloat(8)
    let textAndTranslateStackViewSpacing = CGFloat(8)
    let textAndTranslateStackViewContentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let soundButtonSize = CGSize(width: 24, height: 24)
    let componentsStackViewSpacing = CGFloat(24)
}
private let constants = Constants()

final class WordMeaningSceneView: UIView {
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let textLabel = UILabel()
    let translateLabel = UILabel()
    let soundButton = UIButton()
    let componentsStackView = UIStackView()
    
    private var imageViewHeightConstraint: NSLayoutConstraint!
    private weak var textAndTranslateStackViewWrapperView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func hitTest(
        _ point: CGPoint,
        with event: UIEvent?
    ) -> UIView? {
        if
            let view = textAndTranslateStackViewWrapperView,
            let frame = getSubviewFrame(view: view),
            frame.contains(point) {
            return soundButton
        }
        return super.hitTest(point, with: event)
    }
}

// MARK: - CommonInit

private extension WordMeaningSceneView {
    func commonInit() {
        setConstraints()
        setUI()
        applyStyle()
    }
    
    func setConstraints() {
        let contentView = UIView()
        let textStackView = UIStackView(arrangedSubviews: [textLabel, soundButton]).apply {
            $0.axis = .horizontal
            $0.spacing = constants.textStackViewSpacing
        }
        let textAndTranslateStackView = UIStackView(arrangedSubviews: [textStackView, translateLabel]).apply {
            $0.axis = .vertical
            $0.spacing = constants.textAndTranslateStackViewSpacing
        }
        let textAndTranslateStackViewWrapperView = ViewWrapper(
            view: textAndTranslateStackView,
            inset: constants.textAndTranslateStackViewContentInset
        )
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [imageView, componentsStackView].forEach(contentView.addSubview(_:))
        imageView.addSubview(textAndTranslateStackViewWrapperView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(constants.imageViewContentInset)
        }
        componentsStackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(constants.imageViewContentInset.bottom)
            $0.leading.trailing.equalTo(imageView)
            $0.bottom.lessThanOrEqualToSuperview()
        }
        textAndTranslateStackViewWrapperView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }
        soundButton.snp.makeConstraints {
            $0.size.equalTo(constants.soundButtonSize)
        }
        imageViewHeightConstraint = imageView.heightAnchor.constraint(
            equalTo: imageView.widthAnchor,
            multiplier: constants.imageViewHeightMultiplier
        ).apply {
            $0.isActive = true
        }
        self.textAndTranslateStackViewWrapperView = textAndTranslateStackViewWrapperView
    }
    
    func setUI() {
        imageView.apply {
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = true
            $0.image = Asset.ic60ImagePlaceholder.image
            $0.contentMode = .scaleAspectFit
        }
        soundButton.setImage(Asset.ic24Sound1.image, for: [])
        componentsStackView.apply {
            $0.axis = .vertical
            $0.spacing = constants.componentsStackViewSpacing
        }
    }
    
    func applyStyle() {
        applyViewStyle(ViewStyleFatory.View.commonSceneBackground)
        imageView.applyViewStyle(ViewStyleFatory.Image.meaningImage)
        textLabel.applyTextStyle(TextStyleFactory.BigMessage.mediumLeft)
        translateLabel.applyTextStyle(TextStyleFactory.Message.italicLeft)
        textAndTranslateStackViewWrapperView?.applyViewStyle(ViewStyleFatory.View.shortWordMeaningInfoView)
    }
}

// MARK: - Helpers

extension WordMeaningSceneView {
    func didLoadImage(_ image: UIImage) {
        let newMultiplier = image.size.height / image.size.width
        guard newMultiplier != constants.imageViewHeightMultiplier else { return }
        imageViewHeightConstraint.isActive = false
        imageView.removeConstraint(imageViewHeightConstraint)
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: newMultiplier).apply {
            $0.isActive = true
        }
    }
}
