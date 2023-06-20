import UIKit

import HPCommon
import KakaoSDKAuth
import RxKakaoSDKAuth
import RxKakaoSDKCommon
import NaverThirdPartyLogin
import GoogleSignIn
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        self.makeRootViewController()
        RxKakaoSDK.initSDK(appKey: "e8e2221cc437bed1a098ce95fee11f1d")
        guard let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return true }
        
        naverLoginInstance.isNaverAppOauthEnable = true
        naverLoginInstance.isInAppOauthEnable = true
        naverLoginInstance.setOnlyPortraitSupportInIphone(true)
        naverLoginInstance.serviceUrlScheme = "hobbyloop"
        naverLoginInstance.consumerKey = "rJ3H0X4fD2g_42SnItZq"
        naverLoginInstance.consumerSecret = "JrQwoAXsRX"
        naverLoginInstance.appName = "Hobbyloop"
        
        var decryptionAppId = ""
        do {
            decryptionAppId = try CryptoUtil.makeDecryption(UserDefaults.standard.string(forKey: .accessId))
        } catch {
            print(error.localizedDescription)
        }
        
        
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            // TODO: 이전 사용자 이력이 있기에 MainViewController로 화면 전환
        } else {
            self.makeRootViewController()
        }
        
        let appleLoginProvider = ASAuthorizationAppleIDProvider()
        appleLoginProvider.getCredentialState(forUserID: decryptionAppId) { credentialState, error in
            
            switch credentialState {
            case .revoked:
                self.makeRootViewController()
            case .authorized: break
                // TODO: 인증 성공 상태이므로 MainViewController 로 화면전환
            default:
                break
            }
        }
        
        
        // TODO: 추후 accessToken값이 유효하다면 MainController로 화면 전환 하도록 구현
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


private extension AppDelegate {
    
    func makeRootViewController() {
        DispatchQueue.main.async {
            let loginDIContainer = LoginDIContainer()
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = UINavigationController(rootViewController: loginDIContainer.makeViewController())
            self.window?.makeKeyAndVisible()
        }
    }
    
}
