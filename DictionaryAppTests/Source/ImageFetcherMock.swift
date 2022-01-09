import Foundation
@testable import DictionaryApp
import UIKit

final class ImageFetcherMock: ImageFetcher {
    func fetch(
        _ url: URL,
        completion: @escaping (Result<UIImage?, Error>) -> Void,
        completionQueue: DispatchQueue
    ) -> Cancelable? {
        let task = URLSessionDataTaskMock {
            completionQueue.async {
                completion(.success(Asset.ic60ImagePlaceholder.image))
            }
        }
        task.resume()
        return task
    }
}
