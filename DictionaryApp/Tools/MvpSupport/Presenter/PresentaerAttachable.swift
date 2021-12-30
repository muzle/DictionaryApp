import Foundation

protocol PresenterAttachable {
    associatedtype Presenter
    
    func attach(presenter: Presenter)
}
