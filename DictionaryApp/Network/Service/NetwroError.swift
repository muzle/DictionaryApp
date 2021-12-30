import Foundation

internal enum NetworkError: Error, LocalizedError {
    case decode(Error)
    case network(Error)
    case notValidStatusCode(Int?)
    case undefinedRequest(statusCode: Int?)
    case undefined(Error)
    case convertToQuery(typeName: String)
    case generateUrl(path: String)
    case createUrl(Error)
    
    var errorDescription: String? {
        switch self {
        case .decode(let error):
            return GSln.NetworkError.decode + "\n\(error.localizedDescription)"
        case .network(let error), .undefined(let error):
            if error._code == NSURLErrorTimedOut ||
                error._code == NSURLErrorNotConnectedToInternet ||
                error._code == NSURLErrorNetworkConnectionLost {
                return GSln.NetworkError.badConnection
            } else {
                return GSln.NetworkError.notValidStatus + "\n\(error.localizedDescription)"
            }
        case .notValidStatusCode(let status), .undefinedRequest(let status):
            return status == 404 ? GSln.NetworkError.serverDisable : GSln.NetworkError.notValidStatus
        case .convertToQuery, .generateUrl, .createUrl:
            return GSln.NetworkError.badUrl
        }
    }
}
