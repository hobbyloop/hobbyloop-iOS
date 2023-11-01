import UIKit

import HPCommon
import KakaoSDKAuth
import RxKakaoSDKAuth
import RxKakaoSDKCommon
import NaverThirdPartyLogin
import GoogleSignIn
import AuthenticationServices
import HPCommonUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        
        guard let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return true }
        
        naverLoginInstance.isNaverAppOauthEnable = true
        naverLoginInstance.isInAppOauthEnable = true
        naverLoginInstance.setOnlyPortraitSupportInIphone(true)
        naverLoginInstance.serviceUrlScheme = "hobbyloop"
        naverLoginInstance.consumerKey = "rJ3H0X4fD2g_42SnItZq"
        naverLoginInstance.consumerSecret = "JrQwoAXsRX"
        naverLoginInstance.appName = "Hobbyloop"
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        
        return false
        
    }

}
