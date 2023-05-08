import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let loginViewController = LoginViewController()
        loginViewController.view.backgroundColor = .white
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

