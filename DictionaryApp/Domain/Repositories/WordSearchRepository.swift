import Foundation

public protocol WordSearchRepository {
    @discardableResult
    func search(
        text: String,
        size: Int?,
        page: Int?,
        completion: @escaping (Result<[Word], Error>) -> Void
    ) -> Cancelable?
}

// MARK: - WordSearchRepository + default implementation

extension WordSearchRepository {
    @discardableResult
    func search(
        text: String,
        completion: @escaping (Result<[Word], Error>) -> Void
    ) -> Cancelable? {
        search(
            text: text,
            size: nil,
            page: nil,
            completion: completion
        )
    }
}
