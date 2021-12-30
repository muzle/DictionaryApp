import Foundation

internal final class NetworkFetcherImpl: NetworkFetcher {
    // swiftlint:disable function_parameter_count
    func fetch<T: Decodable>(
        _ request: URLRequest,
        type: T.Type,
        session: URLSession,
        decoder: JSONDecoder,
        completion: @escaping (Result<T, Error>) -> Void,
        completionQueue: DispatchQueue
    ) -> Cancelable? {
        let task = session.dataTask(with: request) { (data, response, error) in
            let response = response as? HTTPURLResponse
            if let error = error {
                let error = NetworkError.network(error)
                completionQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data, let statusCode = response?.statusCode {
                if (200...300).contains(statusCode) {
                    do {
                        let result = try decoder.decode(type.self, from: data)
                        completion(.success(result))
                    } catch {
                        let error = NetworkError.decode(error)
                        completionQueue.async {
                            completion(.failure(error))
                        }
                    }
                } else {
                    let error = NetworkError.notValidStatusCode(statusCode)
                    completionQueue.async {
                        completion(.failure(error))
                    }
                }
            } else {
                let error = NetworkError.undefinedRequest(statusCode: response?.statusCode)
                completionQueue.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        return task
    }
    // swiftlint:enable function_parameter_count
}
