import UIKit

enum ViewStyleFatory {
    enum View {
        static let commonSceneBackground = ViewStyle(backgroundColor: Asset.commonBackgroundColor.color)
        static let shortWordMeaningInfoView = ViewStyle(backgroundColor: Asset.cardColor.color.withAlphaComponent(0.9))
        static let wordCard = ViewStyle(
            backgroundColor: Asset.cardColor.color,
            cornerRadius: 4
        )
    }
    enum Button {
        static let main = ViewStyle(
            backgroundColor: Asset.mainButtonBackgroundColor.color,
            cornerRadius: 10,
            textStyle: TextStyleFactory.Button.main
        )
    }
    enum Image {
        static let meaningImage = ViewStyle(cornerRadius: 4)
    }
}
