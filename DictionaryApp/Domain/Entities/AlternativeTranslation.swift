import Foundation

public struct AlternativeTranslation: Codable, Equatable {
    /// A text of a meaning.
    public let text: String
    public let translation: Translation
}
