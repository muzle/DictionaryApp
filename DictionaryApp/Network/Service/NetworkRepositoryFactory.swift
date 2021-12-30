import Foundation

final class NetworkRepositoryFactory {
    private static let service = NetworkRepositories(
        networkFetcher: NetworkFetcherImpl(),
        imageFetcher: ImageFetcherImpl()
    )
    
    private init() { }
    
    static func makeRepository() -> WordSearchRepository & WordMeaningRepository & ImageRepository {
        service
    }
}
