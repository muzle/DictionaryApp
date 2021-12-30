import Foundation
@testable import DictionaryApp

final class NetworkFetcherMock: NetworkFetcher {
    func fetch<T>(
        _ request: URLRequest,
        type: T.Type,
        session: URLSession,
        decoder: JSONDecoder,
        completion: @escaping (Result<T, Error>) -> Void,
        completionQueue: DispatchQueue
    ) -> Cancelable? where T : Decodable {
        let task = URLSessionDataTaskMock {
            guard let urlPath = request.url?.path else {
                completion(.failure(URLError(.badURL)))
                return
            }
            if urlPath == "/api/public/v1/words/search" {
                do {
                    let result = try getJsonWords(decoder: decoder)
                    completionQueue.async { completion(.success(result as! T)) }
                } catch {
                    completionQueue.async { completion(.failure(error)) }
                }
            } else if urlPath == "/api/public/v1/meanings" {
                do {
                    let result = try getJsonWordMeanings(decoder: decoder)
                    completionQueue.async { completion(.success(result as! T)) }
                } catch {
                    completionQueue.async { completion(.failure(error)) }
                }
            } else {
                completionQueue.async { completion(.failure(URLError(.badURL))) }
            }
        }
        task.resume()
        return task
    }
}
