import Foundation
import UIKit

public protocol SoundUrlContainsType {
    func getSoundUrl() throws -> URL
}

public protocol ImageUrlContainsType {
    func getImageUrl() throws -> URL
}

public protocol WordsUseCase {
    @discardableResult
    func getWordMeanig(
        id: Int,
        completion: @escaping (Result<WordMeaning, Error>) -> Void
    ) -> Cancelable?
    
    @discardableResult
    func getImage(
        for type: ImageUrlContainsType,
        completion: @escaping (Result<UIImage?, Error>) -> Void
    ) -> Cancelable?
    
    @discardableResult
    func findWords(
        with text: String,
        completion: @escaping (Result<[Word], Error>) -> Void
    ) -> Cancelable?
    
    func canPlaySound(for type: SoundUrlContainsType?) -> Bool
    @discardableResult
    func play(for type: SoundUrlContainsType) throws -> Cancelable
}

// MARK: - Default implementation

public extension WordsUseCase {
    func canPlaySound(for type: SoundUrlContainsType?) -> Bool {
        guard let type = type else { return false }
        do {
            _ = try type.getSoundUrl()
            return true
        } catch {
            return false
        }
    }
}
