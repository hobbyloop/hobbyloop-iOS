import UIKit

import NaverThirdPartyLogin
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        // Naver Login
        guard let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return true }
        
        naverLoginInstance.isNaverAppOauthEnable = true
        naverLoginInstance.isInAppOauthEnable = true
        naverLoginInstance.setOnlyPortraitSupportInIphone(true)
        naverLoginInstance.serviceUrlScheme = "hobbyloop"
        naverLoginInstance.consumerKey = "rJ3H0X4fD2g_42SnItZq"
        naverLoginInstance.consumerSecret = "JrQwoAXsRX"
        naverLoginInstance.appName = "Hobbyloop"
        
        // Firebase
        FirebaseApp.configure()
        
        Auth.auth().languageCode = "kr"
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return false
        
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(.noData)
            return
        }
    }
}
