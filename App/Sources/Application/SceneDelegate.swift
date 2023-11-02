//
//  SceneDelegate.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/03/22.
//

import UIKit

import KakaoSDKAuth
import RxKakaoSDKAuth
import RxKakaoSDKCommon
import NaverThirdPartyLogin
import GoogleSignIn
import AuthenticationServices
import HPCommon
import HPCommonUI
import HPNetwork

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    public var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        RxKakaoSDK.initSDK(appKey: "e8e2221cc437bed1a098ce95fee11f1d")
        guard let scene = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: scene)
        
        makeRootViewController()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            setOpenURLKakaoLoign(open: url)
            setOpenURLNaverLogin(open: url)
            setOpenURLGoogleLogin(open: url)
        }
    }
}


extension SceneDelegate {
    
    private func makeRootViewController() {
        if LoginManager.shared.isLogin() {
            window?.rootViewController = CustomTabBarController()
            window?.makeKeyAndVisible()
        } else {
            let loginDIContainer = LoginDIContainer()
            window?.rootViewController = HPNavigationController(
                rootViewController: loginDIContainer.makeViewController(),
                defaultBarAppearance: UINavigationBarAppearance(),
                scrollBarAppearance: UINavigationBarAppearance()
            )
            window?.makeKeyAndVisible()
        }
    }
    
    private func setOpenURLKakaoLoign(open url: URL) {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            _ = AuthController.rx.handleOpenUrl(url: url)
        }
    }
    
    private func setOpenURLNaverLogin(open url: URL) {
        NaverThirdPartyLoginConnection
            .getSharedInstance()
            .receiveAccessToken(url)
    }
    
    private func setOpenURLGoogleLogin(open url: URL) {
        GIDSignIn.sharedInstance.handle(url)
    }
    
    private func setAppleLoginRootViewController() {
        
        var decryptionAppId = ""
        
        do {
            decryptionAppId = try CryptoUtil.makeDecryption(UserDefaults.standard.string(forKey: .accessId))
        } catch {
            print(error.localizedDescription)
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
    }
}
