import Foundation

public struct Word: Codable, Equatable {
    public let id: Int
    public let text: String
    public let meanings: [ShortWordMeaning]
}
