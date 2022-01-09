import Foundation
import XCTest
@testable import DictionaryApp

final class WelcomeScenePresenterTests: XCTestCase, WelcomeSceneDelegate {
    let socialServiceError: Error = URLError(.badURL)
    var presenter: WelcomeScenePresenter!
    var event: WelcomeSceneUnit.Event!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let context = Context(socialService: SocialServiceMock(error: socialServiceError))
        let presenter = WelcomeScenePresenterImpl(
            context: context,
            router: .init({ event in
                self.event = event
            })
        )
        self.presenter = presenter.attach(delegate: self)
    }

    override func tearDownWithError() throws {
        presenter = nil
        try super.tearDownWithError()
    }
    
    func testOpenTelegram() {
        presenter.telegramTap()
        switch event! {
        case .alert(let block):
            testAlertBlock(block: block)
        }
    }
    
    func testOpenMail() {
        presenter.emailTap()
        switch event! {
        case .alert(let block):
            testAlertBlock(block: block)
        }
    }
    
    func testAlertBlock(block: AlertConfigurationBlock) {
        XCTAssertEqual(block.alertConfiguration.title, GSln.Alert.error)
        XCTAssertEqual(block.alertConfiguration.message, socialServiceError.localizedDescription)
        XCTAssertEqual(block.alertConfiguration.style, AlertStyle.error)
        XCTAssertEqual(block.alertConfiguration.actions[0], GSln.Alert.ok)
        XCTAssertEqual(block.alertConfiguration.actions.count, 1)
        XCTAssertEqual(block.alertConfiguration.cancel, nil)
        XCTAssertTrue(block.presented == nil)
        XCTAssertTrue(block.dissmissed == nil)
        XCTAssertTrue(block.actionCompletion == nil)
        XCTAssertTrue(block.cancel == nil)
    }
    
    struct Context: WelcomeScenePresenterImpl.Context {
        var socialService: SocialService
    }
}
