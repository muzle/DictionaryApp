import Foundation

@objc protocol SearchResultScenePresenter {
    @objc optional func searchTextDidChange(text: String)
    @objc optional func cancelButtonTap()
}
