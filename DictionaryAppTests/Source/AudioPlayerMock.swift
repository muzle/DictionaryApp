import Foundation
import DictionaryApp

final class AudioPlayerMock: AudioPlayer {
    func play(url: URL) -> Cancelable {
        CancelableMock()
    }
}

struct CancelableMock: Cancelable {
    func cancel() { }
}
