import Foundation
import UIKit

protocol AlertPresentable {
    func presentAlert(block: AlertConfigurationBlock)
}

extension UIViewController: AlertPresentable {
    func presentAlert(block: AlertConfigurationBlock) {
        let alert = UIAlertController.makeAlert(with: block)
        present(alert, animated: true, completion: block.presented)
    }
}

extension UIAlertController {
    static func makeAlert(with block: AlertConfigurationBlock) -> UIAlertController {
        let alert = UIAlertController(
            title: block.alertConfiguration.title ?? "",
            message: block.alertConfiguration.message ?? "",
            preferredStyle: .init(from: block.alertConfiguration.position)
        )
        
        let attributedTitle = "attributedTitle"
        if let title = block.alertConfiguration.title {
            let attrStr = NSAttributedString(
                string: title,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 18, weight: .medium)
                ]
            )
            alert.setValue(attrStr, forKey: attributedTitle)
        }
        
        let attributedMessage = "attributedMessage"
        if let message = block.alertConfiguration.message {
            let attrStr = NSAttributedString(
                string: message,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 16, weight: .medium)
                ]
            )
            alert.setValue(attrStr, forKey: attributedMessage)
        }
        
        let titleTextColor = "titleTextColor"
        for (index, title) in block.alertConfiguration.actions.enumerated() {
            let action = UIAlertAction(
                title: title,
                style: .default,
                handler: { [block, index] _ in
                    block.actionCompletion?()
                    block.actionIdCompletion?(index)
                }
            )
            action.setValue(UIColor.green, forKey: titleTextColor)
            alert.addAction(action)
        }
        
        if let cancel = block.alertConfiguration.cancel {
            let action = UIAlertAction(
                title: cancel,
                style: .cancel,
                handler: { [block] _ in block.cancel?() }
            )
            action.setValue(UIColor.green, forKey: titleTextColor)
            alert.addAction(action)
        }
        
        if let interval = block.interval {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(interval)) { [block, alert] in
                alert.dismiss(animated: true, completion: block.dissmissed)
            }
        }
        return alert
    }
}
