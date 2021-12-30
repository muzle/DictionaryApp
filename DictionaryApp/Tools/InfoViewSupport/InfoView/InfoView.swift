import UIKit

private struct Constants {
    let stackViewContentInset = UIEdgeInsets(top: 36, left: 16, bottom: 16, right: 16)
    let stackViewSpacing = CGFloat(24)
    let buttonContentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
}
private let constants = Constants()

final class InfoView: UIView {
    typealias Unit = InfoViewUnit
    typealias Presenter = Unit.Handler
    private var presenter: Presenter!
    
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private var contentStackViewBottomConstraint: NSLayoutConstraint!
    
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

private extension InfoView {
    func commonInit() {
        setConstraints()
        setUI()
        applyStyle()
    }
    
    func setConstraints() {
        let contentView = UIView()
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaInsets)
        }
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }
        contentStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(constants.stackViewContentInset)
            $0.bottom.lessThanOrEqualToSuperview().offset(constants.stackViewContentInset.bottom)
        }
        contentStackViewBottomConstraint = contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor).apply {
            $0.isActive = true
        }
    }
    
    func setUI() {
        contentStackView.apply {
            $0.axis = .vertical
            $0.spacing = constants.stackViewSpacing
            $0.alignment = .center
        }
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func applyStyle() {
        applyViewStyle(ViewStyleFatory.View.commonSceneBackground)
    }
}

// MARK: - Implement InfoViewDelegate

extension InfoView: InfoViewDelegate {
    func setComponents(_ types: [InfoViewComponentType]) {
        let views = types.map(makeComponent(for:))
        contentStackView.run {
            $0.removeArrangedSubviews()
            $0.addArrangedSubview(contentsOf: views)
        }
    }
}

// MARK: - Helpers

private extension InfoView {
    func makeComponent(for type: InfoViewComponentType) -> UIView {
        switch type {
        case .image(let image):
            return UIImageView(image: image)
        case .text(let message, let style):
            return UILabel().apply {
                $0.text = message
                $0.applyTextStyle(style)
            }
        case .button(let title):
            return UIButton().apply {
                $0.setTitle(title, for: [])
                $0.applyViewStyle(ViewStyleFatory.Button.main)
                $0.contentEdgeInsets = constants.buttonContentEdgeInsets
                $0.addTarget(for: .touchUpInside, closure: { [weak self] in self?.presenter.tap() })
            }
        }
    }
}

// MARK: - Implement PresenterAttachable

extension InfoView: PresenterAttachable {
    func attach(presenter: Unit.Handler) {
        self.presenter = presenter
        setComponents(presenter.components())
    }
}
