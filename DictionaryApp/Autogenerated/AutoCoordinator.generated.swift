// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import UIKit

protocol CoordinatorsFactory {
    func makeRootSceneCoordinator(
    ) -> RootSceneCoordinator
    func makeWelcomeSceneCoordinator(
        navigation: NavigatorType?
    ) -> WelcomeSceneCoordinator
}

extension Context: CoordinatorsFactory {
    func makeRootSceneCoordinator(
    ) -> RootSceneCoordinator {
        RootSceneCoordinator(
                context: self
        )
    }
    func makeWelcomeSceneCoordinator(
        navigation: NavigatorType?
    ) -> WelcomeSceneCoordinator {
        WelcomeSceneCoordinator(
                context: self,
                navigation: navigation
        )
    }
}
