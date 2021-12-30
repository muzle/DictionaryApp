import Foundation
import UIKit

internal protocol ImageFetcher {
    func fetch(
        _ url: URL,
        completion: @escaping (Result<UIImage?, Error>) -> Void,
        completionQueue: DispatchQueue
    ) -> Cancelable?
}
