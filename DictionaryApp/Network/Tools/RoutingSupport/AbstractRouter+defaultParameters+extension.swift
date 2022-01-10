import Foundation
import ApiRouter

extension AbstractRouter {
    var scheme: String { "https" }
    var policy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    var interval: TimeInterval { 60 }
    
    var publicV1: String { "/api/public/v1" }
    
    var host: String { "dictionary.skyeng.ru" }
    var port: Int? { nil }
    var headers: HTTPHeaders {
        [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json; charset=utf-8"
        ]
    }
}
