import Foundation

public protocol AudioPlayer {
    @discardableResult
    func play(url: URL) -> Cancelable
}
