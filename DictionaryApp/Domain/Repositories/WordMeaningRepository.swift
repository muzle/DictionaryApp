import Foundation

public protocol WordMeaningRepository {
    @discardableResult
    func meaning(
        wordId id: Int,
        updatedAt date: Date?,
        completion: @escaping (Result<[WordMeaning], Error>) -> Void
    ) -> Cancelable?
}

// MARK: - WordMeaningRepository + default implementation

extension WordMeaningRepository {
    @discardableResult
    func meaning(
        wordId id: Int,
        completion: @escaping (Result<[WordMeaning], Error>) -> Void
    ) -> Cancelable? {
        meaning(
            wordId: id,
            updatedAt: nil,
            completion: completion
        )
    }
}
