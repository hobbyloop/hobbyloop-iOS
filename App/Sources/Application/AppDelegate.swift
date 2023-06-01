import UIKit

import KakaoSDKAuth
import RxKakaoSDKAuth
import RxKakaoSDKCommon
import NaverThirdPartyLogin
import GoogleSignIn

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
        naverLoginInstance.setOnlyPortraitSupportInIphone(true)
        naverLoginInstance.serviceUrlScheme = "hobbyloop"
        naverLoginInstance.consumerKey = "rJ3H0X4fD2g_42SnItZq"
        naverLoginInstance.consumerSecret = "JrQwoAXsRX"
        naverLoginInstance.appName = "Hobbyloop"
        
        // TODO: 추후 accessToken값이 유효하다면 MainController로 화면 전환 하도록 구현
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        /// 네이버 로그인 처리
        if NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options) == true {
            return true
        }
        
        /// 카카오 로그인 처리
        if AuthApi.isKakaoTalkLoginUrl(url) == true {
            return AuthController.rx.handleOpenUrl(url: url)
        }
        
        /// 구글 로그인 처리
        if GIDSignIn.sharedInstance.handle(url) {
            return true
        }
        
        return false
        
    }

}

