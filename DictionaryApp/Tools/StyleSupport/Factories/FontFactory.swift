import UIKit

enum FontFactory {
    enum BigMessage {
        static let regular = UIFont.systemFont(ofSize: 20)
        static let medium = UIFont.systemFont(ofSize: 20, weight: .medium)
    }
    enum Message {
        static let regular = UIFont.systemFont(ofSize: 16)
        static let medium = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let italic = UIFont.italicSystemFont(ofSize: 16)
    }
    enum SmallMessage {
        static let regular = UIFont.systemFont(ofSize: 14)
    }
    enum Button {
        static let main = UIFont.systemFont(ofSize: 20, weight: .medium)
    }
    enum Info {
        static let header = UIFont.systemFont(ofSize: 40, weight: .medium)
        static let message = UIFont.systemFont(ofSize: 16)
    }
}
