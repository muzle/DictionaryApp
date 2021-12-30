import Foundation

public struct ShortWordMeaning: Codable, Equatable {
    let id: Int
    let translation: Translation?
    let partOfSpeechCode, previewUrl, imageUrl, transcription, soundUrl: String?
}
