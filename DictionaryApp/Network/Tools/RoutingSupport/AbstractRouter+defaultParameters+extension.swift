import Foundation

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

// MARK: - Convert implementation

extension AbstractRouter {
    func convertToURL(with encoder: JSONEncoder) throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.path = path
        components.host = host
        components.port = port
        
        if let queryParameters = queryParameters {
            let items = try queryParameters.makeQuery(with: encoder)
            if !items.isEmpty {
                components.queryItems = items
            }
        }
        
        guard let url = components.url else { throw NetworkError.generateUrl(path: path) }
        return url
    }
    
    func convertToRequest(with encoder: JSONEncoder) throws -> URLRequest {
        let url = try convertToURL(with: encoder)
        var request = URLRequest(url: url, cachePolicy: policy, timeoutInterval: interval)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let body = body {
            request.httpBody = try body.makeData(with: encoder)
        }
        
        return request
    }
}
