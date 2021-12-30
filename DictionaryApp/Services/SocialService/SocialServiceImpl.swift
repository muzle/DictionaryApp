import Foundation
import UIKit

final class SocialServiceImpl: SocialService {
    func openTelegram(login: String) throws {
        try openUrl("tg://resolve?domain=\(login)", appName: "telegram")
    }
    
    func openEmail(email: String) throws {
        try openUrl("mailto:\(email)", appName: "mail")
    }
    
    private func openUrl(_ urlStr: String, appName: String? = nil) throws {
        guard let url = URL(string: urlStr) else {
            throw URLError(.badURL)
        }
        guard UIApplication.shared.canOpenURL(url) else { throw SocialServiceError.cantOpenApp(name: appName) }
        UIApplication.shared.open(url, options: [:])
    }
    
    enum SocialServiceError: Error, LocalizedError {
        case cantOpenApp(name: String?)
        
        var errorDescription: String? {
            switch self {
            case .cantOpenApp(let name):
                return GSln.SocialServiceError.cantOpenApp(name ?? "")
            }
        }
    }
}
