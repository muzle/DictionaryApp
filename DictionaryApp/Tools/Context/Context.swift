import Foundation

final class Context {
    let socialService: SocialService
    let wordsUseCase: WordsUseCase
    
    init(
        socialService: SocialService,
        wordsUseCase: WordsUseCase
    ) {
        self.socialService = socialService
        self.wordsUseCase = wordsUseCase
    }
}

extension Context: NoContext { }
extension Context: AutoProperties { }
