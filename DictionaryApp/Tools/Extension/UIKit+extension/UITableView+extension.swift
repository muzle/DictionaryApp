import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cell: T.Type) {
        register(T.self, forCellReuseIdentifier: cell.className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(
        _ type: T.Type,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
            preconditionFailure("Error get cell")
        }
        return cell
    }
}
