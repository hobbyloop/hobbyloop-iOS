import UIKit

import KakaoSDKAuth
import RxKakaoSDKAuth
import RxKakaoSDKCommon
import NaverThirdPartyLogin

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
        guard let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return true }
        
        naverLoginInstance.isNaverAppOauthEnable = true
        naverLoginInstance.isInAppOauthEnable = true
        naverLoginInstance.isOnlyPortraitSupportedInIphone()
        naverLoginInstance.serviceUrlScheme = kServiceAppUrlScheme
        naverLoginInstance.consumerKey = kConsumerKey
        naverLoginInstance.consumerSecret = kConsumerSecret
        naverLoginInstance.appName = kServiceAppName
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        setOpenURLNaverLogin(app, open: url, options: options)
        
        return setOpenURLKakaoLoign(open: url)
    }

}



private extension AppDelegate {
    

    
    func setOpenURLKakaoLoign(open url: URL) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.rx.handleOpenUrl(url: url)
        }
        return true
    }
    
    
    func setOpenURLNaverLogin(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])  {
        NaverThirdPartyLoginConnection
            .getSharedInstance()
            .application(app, open: url, options: options)
    }
    
    
}

