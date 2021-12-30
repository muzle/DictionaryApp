import Foundation

protocol AudioPlayer {
    @discardableResult
    func play(url: URL) -> Cancelable
}
