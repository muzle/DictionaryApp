import Foundation

protocol SearchSceneDelegate: AnyObject {
    func searchBarPlaceholder(_ placeholder: String?)
    func searchText(_ text: String?)
}
