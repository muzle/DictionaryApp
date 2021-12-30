import UIKit

private struct Constants {
    let contentInset = UIEdgeInsets.zero
}
private let constants = Constants()

class TableViewWrapperCell<ContentView: UIView>: UITableViewCell {
    lazy var cellContentView = ContentView(frame: bounds)
    var useAnimation = true
    var cellContentViewInset = constants.contentInset {
        willSet {
            guard newValue != cellContentViewInset else { return }
            cellContentView.snp.remakeConstraints {
                $0.edges.equalToSuperview().inset(newValue)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        (self as? Reusable)?.reuse()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        animataTouch(down: highlighted)
        super.setHighlighted(highlighted, animated: animated)
    }
    
    private func commonInit() {
        selectionStyle = .none
        contentView.addSubview(cellContentView)
        cellContentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(cellContentViewInset)
        }
    }
    
    private func animataTouch(down value: Bool) {
        guard useAnimation else { return }
        UIView.animate(withDuration: 0.3) { [cellContentView] in
            cellContentView.transform = .init(scaleX: value ? 0.97 : 1, y: value ? 0.97 : 1)
        }
    }
}

// MARK: - Implement ViewModelBindable

extension TableViewWrapperCell: PresenterAttachable where ContentView: PresenterAttachable {
    func attach(presenter: ContentView.Presenter) {
        cellContentView.attach(presenter: presenter)
    }
}

// MARK: - Implement Reusable

extension TableViewWrapperCell: Reusable where ContentView: Reusable {
    func reuse() {
        cellContentView.reuse()
    }
}
