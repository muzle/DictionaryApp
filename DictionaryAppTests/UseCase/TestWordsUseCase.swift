import Foundation
@testable import DictionaryApp
import XCTest

final class TestWordsUseCase: XCTestCase {
    var useCase: WordsUseCase!
    
    override func setUpWithError() throws {
        useCase = MockContextBuilder().build().wordsUseCase
    }

    override func tearDownWithError() throws {
        useCase = nil
    }
    
    func testSearch() throws {
        let words = try getJsonWords()
        var result: Result<[Word], Error>?
        let expectation = expectation(description: "search")
        useCase.findWords(with: "") { result_ in
            result = result_
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        if let result = result {
            switch result {
            case .success(let models):
                XCTAssertEqual(models, words)
            case .failure(let error):
                throw error
            }
        } else {
            throw NSError(domain: "", code: 0, userInfo: [:])
        }
    }
    
    func testMeaning() throws {
        let meanings = try getJsonWordMeanings()
        var result: Result<WordMeaning, Error>?
        let expectation = expectation(description: "meaning")
        useCase.getWordMeanig(id: 0) { result_ in
            result = result_
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        if let result = result {
            switch result {
            case .success(let model):
                XCTAssertEqual(model, meanings[0])
            case .failure(let error):
                throw error
            }
        } else {
            throw NSError(domain: "", code: 0, userInfo: [:])
        }
    }
    
    func testCanPlaySound() throws {
        XCTAssertTrue(!(useCase.canPlaySound(for: nil)))
        let meaning = try getJsonWordMeanings()[0]
        XCTAssertTrue(useCase.canPlaySound(for: meaning))
        XCTAssertTrue(useCase.canPlaySound(for: meaning.examples[0]))
    }
}
