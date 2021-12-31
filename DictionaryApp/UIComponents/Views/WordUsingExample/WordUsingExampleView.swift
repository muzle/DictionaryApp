import UIKit

private struct Constants {
    let stackViewSpacing = CGFloat(8)
    let contentInset = UIEdgeInsets.zero
    let buttonSize = CGSize(width: 24, height: 24)
}
private let constants = Constants()

final class WordUsingExampleView: UIView {
    typealias Unit = WordUsingExampleViewUnit
    typealias Presenter = Unit.Handler
    private var presenter: Presenter!
    
    private let label = UILabel()
    private let button = UIButton()
    private var stackView: UIStackView!
    
    var contentInset = constants.contentInset {
        willSet {
            guard newValue != contentInset else { return }
            stackView.snp.remakeConstraints {
                $0.edges.equalToSuperview().inset(newValue)
            }
        }
    }
    
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

private extension WordUsingExampleView {
    func commonInit() {
        setConstraints()
        setUI()
        applyStyle()
        registerActions()
    }
    
    func setConstraints() {
        stackView = UIStackView(arrangedSubviews: [button, label]).apply {
            $0.axis = .horizontal
            $0.spacing = constants.stackViewSpacing
            $0.alignment = .center
        }
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(contentInset)
        }
        button.snp.makeConstraints {
            $0.size.equalTo(constants.buttonSize)
        }
    }
    
    func setUI() {
        button.setImage(Asset.ic24Sound2.image, for: [])
    }
    
    func applyStyle() {
        label.applyTextStyle(TextStyleFactory.Message.left)
    }
    
    func registerActions() {
        button.addTarget(for: .touchUpInside) { [weak self] in
            self?.presenter?.play()
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        label.run {
            $0.addGestureRecognizer(tap)
            $0.isUserInteractionEnabled = true
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        presenter.play()
    }
}

// MARK: - Implement WordUsingExampleViewDelegate

extension WordUsingExampleView: WordUsingExampleViewDelegate {
    func setText(_ text: String?) {
        label.text = text
    }
    
    func showButton(_ value: Bool) {
        button.isHidden = !value
    }
}

// MARK: - Implement PresenterAttachable

extension WordUsingExampleView: PresenterAttachable {
    func attach(presenter: Presenter) {
        self.presenter = presenter
        setText(presenter.text())
        showButton(presenter.showSoundButton())
        label.applyTextStyle(presenter.textStyle())
    }
}
