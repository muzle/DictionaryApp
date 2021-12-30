import Foundation
import UIKit

enum InfoViewComponentType {
    case image(UIImage)
    case text(message: String, style: TextStyle)
    case button(String)
}

protocol InfoViewDelegate: AnyObject {
    func setComponents(_ types: [InfoViewComponentType])
}
