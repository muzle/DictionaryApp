import Foundation
import XCTest
@testable import DictionaryApp

final class WordRouterTests: XCTestCase {
    var encoder: JSONEncoder!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        encoder = NsJsonEncoderFactory.customIsoEncoder
    }

    override func tearDownWithError() throws {
        encoder = nil
        try super.tearDownWithError()
    }
    
    func testWordsRoute() throws {
        let route = WordRouter.words(query: WordSearchQuery(search: "Hellop", page: 0, pageSize: 1))
        let url = try route.convertToURL(with: encoder)
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        XCTAssertEqual(components.scheme, "https")
        XCTAssertEqual(components.host, "dictionary.skyeng.ru")
        XCTAssertEqual(components.path, "/api/public/v1/words/search")
        var query = components.queryItems!
        let id1 = query.firstIndex(where: { $0.name == "search" })!
        XCTAssertEqual(query.remove(at: id1).value, "Hellop")
        let id2 = query.firstIndex(where: { $0.name == "page" })!
        XCTAssertEqual(query.remove(at: id2).value, "0")
        let id3 = query.firstIndex(where: { $0.name == "pageSize" })!
        XCTAssertEqual(query.remove(at: id3).value, "1")
        XCTAssertTrue(query.isEmpty)
        
        let request = try route.convertToRequest(with: encoder)
        XCTAssertEqual(request.url?.path, url.path)
    }
    
    func testWordMeaningRoute() throws {
        let date = Date()
        let route = WordRouter.wordMeaning(query: WordMeaningQuery(ids: 9, updatedAt: date))
        let url = try route.convertToURL(with: encoder)
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        XCTAssertEqual(components.scheme, "https")
        XCTAssertEqual(components.host, "dictionary.skyeng.ru")
        XCTAssertEqual(components.path, "/api/public/v1/meanings")
        var query = components.queryItems!
        let id1 = query.firstIndex(where: { $0.name == "ids" })!
        XCTAssertEqual(query.remove(at: id1).value, "9")
        let id2 = query.firstIndex(where: { $0.name == "updatedAt" })!
        XCTAssertEqual(query.remove(at: id2).value!, Formatter.yyyyMMddHHmmss.string(from: date))
        XCTAssertTrue(query.isEmpty)
        
        let request = try route.convertToRequest(with: encoder)
        XCTAssertEqual(request.url?.path, url.path)
    }
}
