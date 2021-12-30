import Foundation

final class ContextBuilder {
    func build() -> Context {
        let wordUseCase = WordsUseCaseImpl(
            networkRepositories: NetworkRepositoryFactory.makeRepository(),
            player: AudioPlayerImpl()
        )
        return Context(
            socialService: SocialServiceImpl(),
            wordsUseCase: wordUseCase
        )
    }
}
