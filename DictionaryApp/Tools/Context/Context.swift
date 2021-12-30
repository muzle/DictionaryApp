import Foundation

final class Context {
    let socialService: SocialService
    
    init(
        socialService: SocialService
    ) {
        self.socialService = socialService
    }
}

extension Context: NoContext { }
extension Context: AutoProperties { }
