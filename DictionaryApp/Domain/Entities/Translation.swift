import Foundation

public struct Translation: Codable, Equatable {
    /// A text of a translation.
    public let text: String
    /// A note about translation.
    public let note: String?
}
