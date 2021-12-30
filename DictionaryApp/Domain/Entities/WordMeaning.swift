import Foundation

public struct WordMeaning: Codable, Equatable {
    public let id: String
    public let wordId, difficultyLevel: Int?
    public let partOfSpeechCode, prefix, text, soundUrl, transcription: String?
    public let updatedAt: Date?
    public let mnemonics: String?
    public let translation: Translation?
    public let images: [Image]
    public let definition: Definition?
    public let examples: [Example]
    public let meaningsWithSimilarTranslation: [MeaningsWithSimilarTranslation]
    public let alternativeTranslations: [AlternativeTranslation]
}
