import Foundation

internal protocol AbstractRouter: URLRequestConvertible {
    var scheme: String { get }
    var host: String { get }
    var port: Int? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    
    var queryParameters: Encodable? { get }
    var body: Encodable? { get }
    var policy: URLRequest.CachePolicy { get }
    var interval: TimeInterval { get }
}
