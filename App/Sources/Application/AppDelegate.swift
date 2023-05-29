import UIKit

import KakaoSDKAuth
import RxKakaoSDKAuth
import RxKakaoSDKCommon

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
        RxKakaoSDK.initSDK(appKey: "e8e2221cc437bed1a098ce95fee11f1d")
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        setOpenURLKakaoLoign(open: url)
    }

}



private extension AppDelegate {
    

    
    func setOpenURLKakaoLoign(open url: URL) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.rx.handleOpenUrl(url: url)
        }
        return false
    }
}

