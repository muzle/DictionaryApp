import UIKit

private struct Constants {
    let cellContentHeight = CGFloat(80)
    let cellContentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
}
private let constants = Constants()

final class SearchWordScene: UITableViewController {
    typealias Unit = SearchWordSceneUnit
    typealias Presenter = Unit.Handler
    
    private var presenter: Presenter!
    private typealias CellModel = SearchWordSceneDelegate.CellModel
    private typealias WordCell = TableViewWrapperCell<WordCard>
    
    private var dataSource: [CellModel] = []
}

// MARK: - Life cycle

extension SearchWordScene {
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            preconditionFailure("presenter must be assigned before viewDidLoad")
        }
        commonInit()
        presenter.didLoad()
    }
}

// MARK: - Implement SearchWordSceneDelegate

extension SearchWordScene: SearchWordSceneDelegate {
    func udpate(dataSource: [SearchWordSceneDelegate.CellModel]) {
        self.dataSource = dataSource
        tableView.reloadData()
    }
}

// MARK: - Common init

private extension SearchWordScene {
    func commonInit() {
        tableView.apply {
            $0.register(WordCell.self)
            $0.separatorStyle = .none
        }
    }
}

// MARK: - Override UITableViewDataSource methods

extension SearchWordScene {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        dataSource.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let anyPresenter = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(WordCell.self, for: indexPath)
        let presenter = anyPresenter.attach(delegate: cell.cellContentView)
        cell.attach(presenter: presenter)
        cell.cellContentViewInset = constants.cellContentInset
        return cell
    }
}

// MARK: - Override UITableViewDelegate methods

extension SearchWordScene {
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        presenter.didSelectIten(index: indexPath.row, section: indexPath.section)
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        constants.cellContentHeight + constants.cellContentInset.vSum
    }
}

// MARK: - Implement PresenterAttachable

extension SearchWordScene: PresenterAttachable {
    func attach(presenter: Unit.Handler) {
        self.presenter = presenter
    }
}
