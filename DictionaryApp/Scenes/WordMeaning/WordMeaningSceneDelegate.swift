import Foundation
import UIKit

enum WordMeaningSceneComponentType {
    case definition(WordUsingExampleViewUnit.Presenter)
    case examples([WordUsingExampleViewUnit.Presenter])
    case similarTranslations([AdditionalTranslateViewUnit.Presenter])
}

protocol WordMeaningSceneDelegate: AnyObject {
    func navigationTitle(_ title: String?)
    func showPreloader(_ value: Bool)
    func setImage(_ image: UIImage, udpateConstraint: Bool)
    func setText(_ text: String?)
    func setTranslate(_ text: String?)
    func showSoundButton(_ value: Bool)
    func setComponents(_ components: [WordMeaningSceneComponentType])
    func showInfoView(_ presenter: InfoViewUnit.Presenter?)
}
