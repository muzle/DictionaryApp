import Foundation
@testable import DictionaryApp

final class ContextBuilderMock {
    func build() -> Context {
        let networkRepositories = NetworkRepositories(
            networkFetcher: NetworkFetcherMock(),
            imageFetcher: ImageFetcherMock()
        )
        let useCase = WordsUseCaseImpl(
            networkRepositories: networkRepositories,
            player: AudioPlayerImpl()
        )
        return Context(
            socialService: SocialServiceImpl(),
            wordsUseCase: useCase
        )
    }
}
