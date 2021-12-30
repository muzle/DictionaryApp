import Foundation

internal extension Encodable {
    func makeQuery(with encoder: JSONEncoder) throws -> [URLQueryItem] {
        let data = try encoder.encode(self)
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NetworkError.convertToQuery(typeName: "\(type(of: self))")
        }
        return json.map(convertToQueryParameter(_:))
    }
    
    func makeData(with encoder: JSONEncoder) throws -> Data {
        return try encoder.encode(self)
    }
    
    private func convertToQueryParameter(_ parameter: (key: String, value: Any)) -> URLQueryItem {
        let (key, value) = parameter
        return URLQueryItem(
            name: key,
            value: String(describing: value)
        )
    }
}
