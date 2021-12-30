import Foundation
import UIKit

final class RootSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory
    typealias Navigator = SingleNavigatorType
    
    private let context: Context
    private let navigation: Navigator
    
    init(
        context: Context
    ) {
        self.context = context
        self.navigation = UIWindow().apply {
            $0.makeKeyAndVisible()
        }
    }
}

// MARK: - Implement CoordinatorType

extension RootSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let nc = NavigationController()
        let coordinator = context.makeWelcomeSceneCoordinator(navigation: nc)
        let scene = coordinator.makeScene()
        nc.pushViewController(scene, animated: false)
        return nc
    }
    
    func setScene() {
        makeScene().run {
            navigation.put($0)
        }
    }
}
