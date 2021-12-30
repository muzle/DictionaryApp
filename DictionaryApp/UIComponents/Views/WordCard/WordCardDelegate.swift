import Foundation
import UIKit

protocol WordCardDelegate: AnyObject {
    func setTitle(_ text: String?)
    func setDescription(_ text: String?)
    func setImage(_ image: UIImage)
}
