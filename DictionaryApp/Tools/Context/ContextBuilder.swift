import Foundation

final class ContextBuilder {
    func build() -> Context {
        return Context(
            socialService: SocialServiceImpl()
        )
    }
}
