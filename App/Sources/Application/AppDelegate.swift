import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let loginDIContainer = LoginDIContainer()
        window?.rootViewController = UINavigationController(rootViewController: loginDIContainer.makeViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

}

