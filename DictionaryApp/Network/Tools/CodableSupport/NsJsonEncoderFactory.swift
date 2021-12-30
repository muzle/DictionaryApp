import Foundation

internal enum NsJsonEncoderFactory {
    static let commonEncoder = JSONEncoder()
    
    static let customIsoEncoder: JSONEncoder = {
        let decoder = JSONEncoder()
        decoder.dateEncodingStrategy = .customISO8601
        return decoder
    }()
}

// MARK: - Custom Date DateEncodingStrategy

extension JSONEncoder.DateEncodingStrategy {
    static let customISO8601 = custom { date, encoder in
        var container = encoder.singleValueContainer()
        let text = Formatter.yyyyMMddHHmmss.string(from: date)
        try container.encode(text)
    }
}
