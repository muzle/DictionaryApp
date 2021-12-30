import UIKit

protocol ImageRepository {
    func loadImage(
        with url: URL,
        completion: @escaping (Result<UIImage?, Error>) -> Void
    ) -> Cancelable?
    
    func loadImage(
        with urlString: String,
        completion: @escaping (Result<UIImage?, Error>) -> Void
    ) -> Cancelable?
}
