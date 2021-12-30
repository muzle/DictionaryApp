import Foundation

internal enum NsJsonDecoderFactory {
    static let commonDecoder = JSONDecoder()
    
    static let customIsoDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customISO8601
        return decoder
    }()
}

// MARK: - Custom Date DateDecodingStrategy

private extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601 = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.yyyyMMddHHmmss.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
