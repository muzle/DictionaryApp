import Foundation

internal enum WordRouter {
    case words(query: Encodable)
    case wordMeaning(query: Encodable)
}

// MARK: - Implement AbstractRouter

extension WordRouter: AbstractRouter {
    var path: String {
        switch self {
        case .words:
            return publicV1 + "/words/search"
        case .wordMeaning:
            return publicV1 + "/meanings"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryParameters: Encodable? {
        switch self {
        case .wordMeaning(let query), .words(let query):
            return query
        }
    }
    
    var body: Encodable? {
        nil
    }
}
