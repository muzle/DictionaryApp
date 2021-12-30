import Foundation

protocol SearchWordSceneDelegate: AnyObject {
    typealias CellModel = WordCardUnit.Presenter
    func udpate(dataSource: [CellModel])
    func showPreloader(_ value: Bool)
    func showInfoView(_ presenter: InfoViewUnit.Presenter?)
}
