import UIKit

public protocol CoordinatorType {
    func makeScene() -> UIViewController
    
    func setScene()
}

extension CoordinatorType {
    func setScene() {
        #if DEBUG
        // swiftlint:disable dont_use_print
        print("Set scene has not been implemented")
        // swiftlint:enable dont_use_print
        #endif
    }
}
