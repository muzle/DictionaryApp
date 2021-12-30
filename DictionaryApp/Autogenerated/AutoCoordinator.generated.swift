// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import UIKit

protocol CoordinatorsFactory {
    func makeRootSceneCoordinator(
    ) -> RootSceneCoordinator
    func makeSearchSceneCoordinator(
        configuration: SearchSceneCoordinator.Configuration
    ) -> SearchSceneCoordinator
    func makeSearchWordSceneCoordinator(
        navigation: NavigatorType?,
        configuration: SearchWordSceneCoordinator.Configuration
    ) -> SearchWordSceneCoordinator
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
    func makeSearchSceneCoordinator(
        configuration: SearchSceneCoordinator.Configuration
    ) -> SearchSceneCoordinator {
        SearchSceneCoordinator(
                context: self,
                configuration: configuration
        )
    }
    func makeSearchWordSceneCoordinator(
        navigation: NavigatorType?,
        configuration: SearchWordSceneCoordinator.Configuration
    ) -> SearchWordSceneCoordinator {
        SearchWordSceneCoordinator(
                context: self,
                navigation: navigation,
                configuration: configuration
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
