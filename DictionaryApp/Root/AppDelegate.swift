import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var rootCoordinator: CoordinatorType!
    private var context: Context!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        context = ContextBuilder().build()
        rootCoordinator = context.makeRootSceneCoordinator()
        rootCoordinator.setScene()
        return true
    }
}
