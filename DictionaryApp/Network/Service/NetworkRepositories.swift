import Foundation
import UIKit

final class NetworkRepositories {
    private let networkFetcher: NetworkFetcher
    private let imageFetcher: ImageFetcher
    
    init(
        networkFetcher: NetworkFetcher,
        imageFetcher: ImageFetcher
    ) {
        self.networkFetcher = networkFetcher
        self.imageFetcher = imageFetcher
    }
}

// MARK: - Implement WordSearchRepository

extension NetworkRepositories: WordSearchRepository {
    func search(
        text: String,
        size: Int?,
        page: Int?,
        completion: @escaping (Result<[Word], Error>) -> Void
    ) -> Cancelable? {
        let query = WordSearchQuery(search: text, page: page, pageSize: size)
        return fetch(
            WordRouter.words(query: query),
            type: [Word].self,
            completion: completion
        )
    }
}

// MARK: - Implement WordMeaningRepository

extension NetworkRepositories: WordMeaningRepository {
    func meaning(
        wordId id: Int,
        updatedAt date: Date?,
        completion: @escaping (Result<[WordMeaning], Error>) -> Void
    ) -> Cancelable? {
        let query = WordMeaningQuery(ids: id, updatedAt: date)
        return fetch(
            WordRouter.wordMeaning(query: query),
            type: [WordMeaning].self,
            encoder: NsJsonEncoderFactory.customIsoEncoder,
            decoder: NsJsonDecoderFactory.customIsoDecoder,
            completion: completion
        )
    }
}

// MARK: - Implement ImageRepository

extension NetworkRepositories: ImageRepository {
    func loadImage(
        with url: URL,
        completion: @escaping (Result<UIImage?, Error>) -> Void
    ) -> Cancelable? {
        imageFetcher.fetch(
            url,
            completion: completion,
            completionQueue: .main
        )
    }
    
    func loadImage(with urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancelable? {
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return nil
        }
        return loadImage(with: url, completion: completion)
    }
}

// MARK: - Helpers

private extension NetworkRepositories {
    private func fetch<Router: AbstractRouter, DataType: Decodable>(
        _ route: Router,
        type: DataType.Type,
        session: URLSession = .shared,
        encoder: JSONEncoder = NsJsonEncoderFactory.commonEncoder,
        decoder: JSONDecoder = NsJsonDecoderFactory.commonDecoder,
        completion: @escaping (Result<DataType, Error>) -> Void,
        completionQueue: DispatchQueue = .global(qos: .background)
    ) -> Cancelable? {
        do {
            let request = try route.convertToRequest(with: encoder)
            return networkFetcher.fetch(
                request,
                type: type.self,
                session: session,
                decoder: decoder,
                completion: completion,
                completionQueue: completionQueue
            )
        } catch {
            guard let nsError = error as? NetworkError else {
                completion(.failure((NetworkError.undefined(error) as Error)))
                return nil
            }
            completion(.failure(nsError))
            return nil
        }
    }
}
