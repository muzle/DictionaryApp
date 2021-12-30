import Foundation

private func extendUrlString(string: String?) -> String? {
    guard var string = string else { return nil }
    if !string.contains("https:") {
        string = "https:" + string
    }
    return string
}

private func makeUrl(from string: String?) throws -> URL {
    guard
        let urlStr = extendUrlString(string: string),
        let url = URL(string: urlStr)
    else {
        throw URLError(.badURL)
    }
    return url
}

// MARK: - Example implement SoundUrlContainsType

extension Example: SoundUrlContainsType {
    public func getSoundUrl() throws -> URL {
        try makeUrl(from: soundUrl)
    }
}

// MARK: - Definition implement SoundUrlContainsType

extension Definition: SoundUrlContainsType {
    public func getSoundUrl() throws -> URL {
        try makeUrl(from: soundUrl)
    }
}

// MARK: - WordMeaning implement SoundUrlContainsType & ImageUrlContainsType

extension WordMeaning: SoundUrlContainsType, ImageUrlContainsType {
    public func getSoundUrl() throws -> URL {
        try makeUrl(from: soundUrl)
    }
    
    public func getImageUrl() throws -> URL {
        try makeUrl(from: images[safe: 0]?.url)
    }
}

// MARK: - ShortWordMeaning Implement ImageUrlContainsType

extension ShortWordMeaning: ImageUrlContainsType {
    public func getImageUrl() throws -> URL {
        try makeUrl(from: imageUrl)
    }
}

// MARK: - Word Implement ImageUrlContainsType

extension Word: ImageUrlContainsType {
    public func getImageUrl() throws -> URL {
        try makeUrl(from: meanings.first?.previewUrl)
    }
}
