import Foundation

protocol SocialService {
    func openTelegram(login: String) throws
    func openEmail(email: String) throws
}
