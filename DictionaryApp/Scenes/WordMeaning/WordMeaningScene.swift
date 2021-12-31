import UIKit

private struct Constants {
    let examplesStackViewSpacing = CGFloat(8)
}
private let constants = Constants()

final class WordMeaningScene: UIViewController {
    typealias Unit = WordMeaningSceneUnit
    typealias Presenter = Unit.Handler
    typealias ContentView = WordMeaningSceneView
    
    private var presenter: Presenter!
    private lazy var contentView = ContentView()
    private weak var infoView: UIView?
}

// MARK: - Life cycle

extension WordMeaningScene {
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            preconditionFailure("presenter must be assigned before viewDidLoad")
        }
        commonInit()
        presenter.didLoad()
    }
}

// MARK: - Implement WordMeaningSceneDelegate

extension WordMeaningScene: WordMeaningSceneDelegate {
    func navigationTitle(_ title: String?) {
        navigationItem.title = title
    }
    func setImage(_ image: UIImage, udpateConstraint: Bool) {
        contentView.imageView.image = image
        if udpateConstraint {
            contentView.didLoadImage(image)
        }
    }
    func setText(_ text: String?) {
        contentView.textLabel.text = text
    }
    func setTranslate(_ text: String?) {
        contentView.translateLabel.text = text
    }
    func showSoundButton(_ value: Bool) {
        contentView.soundButton.isHidden = !value
    }
    func setComponents(_ components: [WordMeaningSceneComponentType]) {
        let views = components.map(makeComponentView(with:))
        contentView.componentsStackView.run {
            $0.removeArrangedSubviews()
            $0.addArrangedSubview(contentsOf: views)
        }
    }
}

// MARK: - Common init

private extension WordMeaningScene {
    func commonInit() {
        registerAtions()
    }
    
    private func registerAtions() {
        contentView.soundButton.addTarget(for: .touchUpInside) { [presenter] in presenter?.playSound() }
    }
}

// MARK: - Implement PresenterAttachable

extension WordMeaningScene: PresenterAttachable {
    func attach(presenter: Unit.Handler) {
        self.presenter = presenter
    }
}

// MARK: - Helpers

private extension WordMeaningScene {
    private func makeComponentView(with type: WordMeaningSceneComponentType) -> UIView {
        let view: UIView
        switch type {
        case .definition(let presenter):
            view = makeExampleView(presenter: presenter)
        case .examples(let presenters):
            let views = presenters.map(makeExampleView(presenter:))
            view = UIStackView(arrangedSubviews: views).apply {
                $0.axis = .vertical
                $0.spacing = constants.examplesStackViewSpacing
            }
        case .similarTranslations(let presenters):
            let views = presenters.map(makeSimilatTranslationView(presenter:))
            let stackView = UIStackView(arrangedSubviews: views).apply {
                $0.axis = .vertical
                $0.spacing = constants.examplesStackViewSpacing
            }
            view = wrappViewToSection(
                with: GSln.WordMeaningScene.anotherTranslation,
                view: stackView
            )
        }
        return view
    }
    
    private func wrappViewToSection(
        with title: String,
        view: UIView
    ) -> UIView {
        let label = UILabel().apply {
            $0.text = title
            $0.applyTextStyle(TextStyleFactory.Message.leftMedium)
        }
        return UIStackView(arrangedSubviews: [label, view]).apply {
            $0.axis = .vertical
            $0.spacing = 10
        }
    }
    private func makeExampleView(presenter: WordUsingExampleViewUnit.Presenter) -> UIView {
        let view = WordUsingExampleView()
        let handler = presenter.attach(delegate: view)
        view.attach(presenter: handler)
        return view
    }
    private func makeSimilatTranslationView(presenter: AdditionalTranslateViewUnit.Presenter) -> UIView {
        let view = AdditionalTranslateView()
        let handler = presenter.attach(delegate: view)
        view.attach(presenter: handler)
        return view
    }
}
