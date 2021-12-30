import Foundation

public struct MeaningsWithSimilarTranslation: Codable, Equatable {
    public let meaningId: Int
    public let frequencyPercent, partOfSpeechAbbreviation: String?
    public let translation: Translation?
}
