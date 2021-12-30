import Foundation

// swiftlint:disable function_parameter_count
internal protocol NetworkFetcher {
    func fetch<T: Decodable>(
        _ request: URLRequest,
        type: T.Type,
        session: URLSession,
        decoder: JSONDecoder,
        completion: @escaping (Result<T, Error>) -> Void,
        completionQueue: DispatchQueue
    ) -> Cancelable?
}
// swiftlint:enable function_parameter_count
