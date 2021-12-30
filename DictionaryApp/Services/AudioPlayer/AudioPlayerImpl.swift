import Foundation
import AVFoundation

final class AudioPlayerImpl {
    private var player: AVPlayer?
}

// MARK: - Implement AudioPlayer

extension AudioPlayerImpl: AudioPlayer {
    func play(url: URL) -> Cancelable {
        let item = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: item)
        player.play()
        self.player = player
        return self
    }
}

// MARK: - Implement Cancelable

extension AudioPlayerImpl: Cancelable {
    func cancel() {
        player = nil
    }
}
