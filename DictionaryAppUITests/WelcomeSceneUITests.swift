import XCTest
@testable import DictionaryApp

class WelcomeSceneUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testTelegramTap() throws {
        app.buttons["Write to Telegram"].tap()
    }
    
    func testEmailTap() throws {
        app.buttons["Email him"].tap()
    }
}
