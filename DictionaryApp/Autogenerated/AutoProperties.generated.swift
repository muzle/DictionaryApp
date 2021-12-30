// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation

// MARK: - Context

protocol HasSocialService { var socialService: SocialService { get } }
extension Context: HasSocialService { }

protocol HasWordsUseCase { var wordsUseCase: WordsUseCase { get } }
extension Context: HasWordsUseCase { }
