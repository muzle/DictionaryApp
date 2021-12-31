import Foundation

enum WordUsingExampleViewUnit: UnitType {
    enum Event {
        case error(Error)
    }
    typealias Delegate = WordUsingExampleViewDelegate
    typealias Handler = WordUsingExampleViewPresenter
}

protocol WordUsingExampleViewPresenter {
    func text() -> String?
    func showSoundButton() -> Bool
    func play()
    func textStyle() -> TextStyle
}
