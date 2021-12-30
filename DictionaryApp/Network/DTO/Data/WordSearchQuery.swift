import Foundation

internal struct WordSearchQuery: Encodable {
    let search: String
    let page, pageSize: Int?
}
