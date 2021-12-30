import Foundation
import UIKit
import SDWebImage

internal final class ImageFetcherImpl {
    private let imageManager: SDWebImageManager
    
    init(imageManager: SDWebImageManager = SDWebImageManager()) {
        self.imageManager = imageManager
    }
}

// MARK: - Implement ImageFetcher

extension ImageFetcherImpl: ImageFetcher {
    func fetch(
        _ url: URL,
        completion: @escaping (Result<UIImage?, Error>) -> Void,
        completionQueue: DispatchQueue
    ) -> Cancelable? {
        imageManager.loadImage(
            with: url,
            context: nil,
            progress: nil,
            completed: { image, _, error, _, _, _ in
                completionQueue.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success(image))
                }
            }
        )
    }
}
