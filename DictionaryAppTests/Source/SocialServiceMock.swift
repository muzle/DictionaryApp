import Foundation
import DictionaryApp

final class SocialServiceMock: SocialService {
    var error: Error?
    
    init(error: Error? = URLError(.badURL)) {
        self.error = error
    }
    
    func openTelegram(login: String) throws {
        guard let error = error else { return }
        throw error
    }
    
    func openEmail(email: String) throws {
        guard let error = error else { return }
        throw error
    }
}
