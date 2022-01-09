import Foundation
@testable import DictionaryApp
import XCTest

final class TestNetworkRepositories: XCTestCase {
    typealias Repository = WordSearchRepository & WordMeaningRepository & ImageRepository
    
    var repository: Repository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = NetworkRepositories(
            networkFetcher: NetworkFetcherMock(),
            imageFetcher: ImageFetcherMock()
        )
    }

    override func tearDownWithError() throws {
        repository = nil
        try super.tearDownWithError()
    }
    
    func testSearch() throws {
        let words = try getJsonWords()
        var result: Result<[Word], Error>?
        let expectation = expectation(description: "search")
        repository.search(text: "") { result_ in
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
        var result: Result<[WordMeaning], Error>?
        let expectation = expectation(description: "meaning")
        repository.meaning(wordId: 0) { result_ in
            result = result_
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        if let result = result {
            switch result {
            case .success(let models):
                XCTAssertEqual(models, meanings)
            case .failure(let error):
                throw error
            }
        } else {
            throw NSError(domain: "", code: 0, userInfo: [:])
        }
    }
}
