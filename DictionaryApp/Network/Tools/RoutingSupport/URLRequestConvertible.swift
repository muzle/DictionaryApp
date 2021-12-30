import Foundation

internal protocol URLRequestConvertible {
    func convertToURL(with encoder: JSONEncoder) throws -> URL
    func convertToRequest(with encoder: JSONEncoder) throws -> URLRequest
}
