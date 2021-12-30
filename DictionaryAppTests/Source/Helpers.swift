import Foundation
@testable import DictionaryApp

private class A { }

func readJsonFileToModel<T: Decodable>(
    fileName: String,
    decoder: JSONDecoder,
    type: T.Type
) throws -> T {
    guard
        let path = Bundle(for: A.self).path(forResource: fileName, ofType: "json"),
        let data = NSData(contentsOfFile: path)
    else {
        throw URLError(.badURL)
    }
    return try decoder.decode(type.self, from: data as Data)
}

func getJsonWords(decoder: JSONDecoder = NsJsonDecoderFactory.customIsoDecoder) throws -> [Word] {
    try readJsonFileToModel(
        fileName: "SkyengHelloSearchResult",
        decoder: decoder,
        type: [Word].self
    )
}

func getJsonWordMeanings(decoder: JSONDecoder = NsJsonDecoderFactory.customIsoDecoder) throws -> [WordMeaning] {
    try readJsonFileToModel(
        fileName: "SkyengHelloMeaningResult",
        decoder: decoder,
        type: [WordMeaning].self
    )
}
