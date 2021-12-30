import Foundation
import UIKit

final class WordsUseCaseImpl {
    typealias NetworkRepositories = WordMeaningRepository & ImageRepository & WordSearchRepository
    private let networkRepositories: NetworkRepositories
    private let player: AudioPlayer
    
    init(
        networkRepositories: NetworkRepositories,
        player: AudioPlayer
    ) {
        self.networkRepositories = networkRepositories
        self.player = player
    }
}

// MARK: - Implement WordsUseCase

extension WordsUseCaseImpl: WordsUseCase {
    func getWordMeanig(
        id: Int,
        completion: @escaping (Result<WordMeaning, Error>) -> Void
    ) -> Cancelable? {
        networkRepositories.meaning(
            wordId: id,
            completion: { [self] result in
                DispatchQueue.main.async {
                    completion(result.flatMap(getRequiredWordMeaning))
                }
            }
        )
    }
    
    func getImage(
        for type: ImageUrlContainsType,
        completion: @escaping (Result<UIImage?, Error>) -> Void
    ) -> Cancelable? {
        do {
            let url = try type.getImageUrl()
            return networkRepositories.loadImage(
                with: url,
                completion: { result in
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
            )
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            return nil
        }
    }
    
    func findWords(
        with text: String,
        completion: @escaping (Result<[Word], Error>) -> Void
    ) -> Cancelable? {
        networkRepositories.search(
            text: text,
            size: 100,
            page: 1,
            completion: { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        )
    }
    
    @discardableResult
    func play(for type: SoundUrlContainsType) throws -> Cancelable {
        let url = try type.getSoundUrl()
        return player.play(url: url)
    }
    
    private func getRequiredWordMeaning(_ meanings: [WordMeaning]) -> Result<WordMeaning, Error> {
        guard let meaning = meanings[safe: 0] else {
            return .failure(WordsUseCaseImplError.emptyWordMeaning)
        }
        return .success(meaning)
    }
    
    private enum WordsUseCaseImplError: Error {
        case emptyWordMeaning
    }
}
