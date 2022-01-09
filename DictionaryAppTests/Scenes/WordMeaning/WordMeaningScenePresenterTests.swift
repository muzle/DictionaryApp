import Foundation
import XCTest
@testable import DictionaryApp

final class WordMeaningScenePresenterTests: XCTestCase, WordMeaningSceneDelegate {
    var presenter: WordMeaningScenePresenter!
    var event: WordMeaningSceneUnit.Event!
    
    private var navigationTitle: String?
    private var showPreloader: Bool?
    private var image: UIImage?
    private var updateConstraint: Bool?
    private var text: String?
    private var translate: String?
    private var showSoundButton: Bool?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let wordsFetcher = NetworkFetcherMock()
        let imageFetcher = ImageFetcherMock()
        let repo = NetworkRepositories(
            networkFetcher: wordsFetcher,
            imageFetcher: imageFetcher
        )
        let player = AudioPlayerMock()
        let useCase = WordsUseCaseImpl(networkRepositories: repo, player: player)
        let context = Context(wordsUseCase: useCase)
        let presenter = WordMeaningScenePresenterImpl(
            context: context,
            configuration: .init(id: 1),
            router: .init({ event in
                self.event = event
            })
        )
        self.presenter = presenter.attach(delegate: self)
    }

    override func tearDownWithError() throws {
        presenter = nil
        navigationTitle = nil
        showPreloader = nil
        image = nil
        updateConstraint = nil
        text = nil
        translate = nil
        showSoundButton = nil
        try super.tearDownWithError()
    }
    
    func testLoad() throws {
        presenter.didLoad()
        XCTAssertEqual(showPreloader, true)
        let expectation = expectation(description: "preloader")
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            expectation.fulfill()
        }
        let meaning = try getJsonWordMeanings().first!
        let showSoundButton = URL(string: meaning.soundUrl ?? "") != nil
        waitForExpectations(timeout: 2, handler: .none)
        XCTAssertEqual(showPreloader, false)
        XCTAssertEqual(navigationTitle, meaning.text?.capitalizingFirstLetter())
        XCTAssertEqual(image, Asset.ic60ImagePlaceholder.image)
        XCTAssertEqual(updateConstraint, true)
        XCTAssertEqual(text, meaning.text?.uppercased())
        XCTAssertEqual(translate, meaning.translation?.text.capitalizingFirstLetter())
        XCTAssertEqual(self.showSoundButton, showSoundButton)
    }
        
    func navigationTitle(_ title: String?) {
        self.navigationTitle = title
    }
    
    func showPreloader(_ value: Bool) {
        showPreloader = value
    }
    
    func setImage(_ image: UIImage, updateConstraint: Bool) {
        self.image = image
        self.updateConstraint = updateConstraint
    }
    
    func setText(_ text: String?) {
        self.text = text
    }
    
    func setTranslate(_ text: String?) {
        translate = text
    }
    
    func showSoundButton(_ value: Bool) {
        self.showSoundButton = value
    }
    
    func setComponents(_ components: [WordMeaningSceneComponentType]) {
    }
    
    func showInfoView(_ presenter: InfoViewUnit.Presenter?) {
        
    }
    
    struct Context: WordMeaningScenePresenterImpl.Context {
        var wordsUseCase: WordsUseCase
    }
}
