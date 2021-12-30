import Foundation

enum TextStyleFactory {
    enum BigMessage {
        static let center = TextStyle(
            font: FontFactory.BigMessage.regular,
            color: Asset.commonTextColor.color,
            alignment: .center
        )
        static let left = center.byAdding(.alignment(.left))
        
        static let mediumCenter = center.byAdding(.font(FontFactory.BigMessage.medium))
        static let mediumLeft = mediumCenter.byAdding(.alignment(.left))
    }
    enum Message {
        static let center = TextStyle(
            font: FontFactory.Message.regular,
            color: Asset.commonTextColor.color,
            alignment: .center
        )
        static let left = center.byAdding(.alignment(.left))
        static let leftMedium = left.byAdding(.font(FontFactory.Message.medium))
        static let italicLeft = left.byAdding(.font(FontFactory.Message.italic))
    }
    enum SmallMessage {
        static let center = TextStyle(
            font: FontFactory.SmallMessage.regular,
            color: Asset.commonTextColor.color,
            alignment: .center
        )
        static let left = center.byAdding(.alignment(.left))
        static let italicLeft = left.byAdding(.font(FontFactory.Message.italic))
    }
    enum Button {
        static let main = TextStyle(
            font: FontFactory.Button.main,
            color: Asset.mainButtonTextColor.color,
            alignment: .center
        )
    }
    enum Info {
        static let headerCenter = TextStyle(
            font: FontFactory.Info.header,
            color: Asset.infoHeaderColor.color,
            alignment: .center
        )
        static let messageCenter = TextStyle(
            font: FontFactory.Info.message,
            color: Asset.infoMessageColor.color,
            alignment: .center
        )
    }
}
