//
//  LoginViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/09.
//

import Foundation

import HPCommon
import HPExtensions
import ReactorKit
import KakaoSDKUser
import KakaoSDKAuth
import RxKakaoSDKUser
import RxKakaoSDKAuth
import KakaoSDKCommon
import NaverThirdPartyLogin
import GoogleSignIn
import AuthenticationServices

public protocol LoginViewRepo {
    var disposeBag: DisposeBag { get }
    var naverLoginInstance: NaverThirdPartyLoginConnection { get }
    var googleLoginInstance: GIDConfiguration { get }
    
    /// 카카오 로그인을 위한 implementation
    func responseKakaoLogin() -> Observable<LoginViewReactor.Mutation>
    func responseKakaoWebLogin() -> Observable<LoginViewReactor.Mutation>
    func resultKakaoLogin() -> Observable<LoginViewReactor.Mutation>
    func responseRefreshKakaoToken() -> Void
    func isExpiredKakaoToken() -> Void

    /// 네이버 로그인을 위한 implementation
    func responseNaverLogin() -> Observable<LoginViewReactor.Mutation>
    
    /// 구글 로그인을 위한 implementation
    func responseGoogleLogin(to viewController: AnyObject) -> Observable<LoginViewReactor.Mutation>
    
    /// 애플 로그인을 위한 implementation
    func responseAppleLogin() -> Observable<LoginViewReactor.Mutation>
    
}


public final class LoginViewRepository: NSObject, LoginViewRepo {
    public var disposeBag: DisposeBag = DisposeBag()
    
    public let naverLoginInstance: NaverThirdPartyLoginConnection = NaverThirdPartyLoginConnection.getSharedInstance()
    public let googleLoginInstance: GIDConfiguration = GIDConfiguration(clientID: "565615287672-emohfjcbdultg158jdvjrbkuqsgbps8a.apps.googleusercontent.com")
    
    
    public override init() {
        super.init()
        self.naverLoginInstance.delegate = self
    }
    
    /// 카카오 에서 발급 받은 Access Token  값이 유효한지 확인하는 메서드
    /// - note: suceess에 떨어지는 경우 accessToken 값이 유효 한 경우, 혹은 필요시 Access Token 값을 갱신 해줌
    /// - parameters: none Parameters
    public func isExpiredKakaoToken() -> Void {
        
        if (AuthApi.hasToken()) {
            UserApi.shared.rx.accessTokenInfo()
                .subscribe(onSuccess: { accessToken in
                    // 토큰 유효한 것 확인 -> SignUpController 화면 전환
                    debugPrint("success Token : \(accessToken)")
                }, onFailure: { error in
                    if let sdkError = error as? SdkError,
                       sdkError.isInvalidTokenError() == true {
                        self.responseRefreshKakaoToken()
                    }
                }).disposed(by: disposeBag)
            
        }
    }
    
    /// 최종적으로 카카오톡 실치 여부를 확인 하여 로그인을 실행하는 메서드
    /// - note: 카카오톡 설치 여부에 따라 웹 로그인 또는 in-App 로그인을 실행 하는 메서드
    /// - parameters: none Parameters
    public func resultKakaoLogin() -> RxSwift.Observable<LoginViewReactor.Mutation> {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            return responseKakaoLogin()
        } else {
            return responseKakaoWebLogin()
        }
    }
    
    /// 카카오 로그인창 창을 띄우기 위한 메서드
    ///  - note: 로그인이 필요한 경우 일때 호출 해야하는 메서드
    ///  - parameters: none Parameters
    public func responseKakaoLogin() -> Observable<LoginViewReactor.Mutation> {
        return UserApi.shared.rx.loginWithKakaoTalk()
            .asObservable()
            .flatMap { accessToken -> Observable<LoginViewReactor.Mutation> in
                do {
                    let chiperToken = try CryptoUtil.makeEncryption(accessToken.accessToken)
                    UserDefaults.standard.set(chiperToken, forKey: .accessToken)
                    UserDefaults.standard.set(accessToken.expiredAt, forKey: .expiredAt)
                    debugPrint("암호화 토큰 : \(chiperToken)")
                    return .just(.setKakaoAccessToken(chiperToken))
                } catch {
                    debugPrint(error.localizedDescription)
                }
                return .empty()
            }
    }
    
    
    /// 카카오 웹로그인 창을 띄우기 위한 메서드
    /// - note: 로그인이 필요한 경우 및 사용자가 카카오톡이 깔려 있지 않는 경우 웹 브라우저를 띄운다.
    /// - parameters: none Parameters
    public func responseKakaoWebLogin() -> RxSwift.Observable<LoginViewReactor.Mutation> {
        return UserApi.shared.rx.loginWithKakaoAccount()
            .asObservable()
            .flatMap { accessToken -> Observable<LoginViewReactor.Mutation> in
                do {
                    let chiperToken = try CryptoUtil.makeEncryption(accessToken.accessToken)
                    UserDefaults.standard.set(chiperToken, forKey: .accessToken)
                    UserDefaults.standard.set(accessToken.expiredAt, forKey: .expiredAt)
                    debugPrint("웹 로그인 암호화 토큰 : \(chiperToken)")
                    return .just(.setKakaoAccessToken(chiperToken))
                } catch {
                    debugPrint(error.localizedDescription)
                }
                return .empty()
            }
    }
        
    /// 카카오 토큰을 리프레쉬 하기 위한 메서드
    /// - note: 기존 accessToken, refreshToek을 refresh 하기 위한 메서드
    /// - Parameters: none Parameters
    public func responseRefreshKakaoToken() -> Void {
        
        var cipherRefreshToken: String = ""
        guard let expiredAt: Date = UserDefaults.standard.object(forKey: .expiredAt) as? Date else { return }
        
        
        if Date().converToExpiredoDate().dateCompare(fromDate: expiredAt) == "Past" {
            AuthApi.shared.rx.refreshToken()
                .debug()
                .subscribe(onSuccess: { refreshToken in
                    print("success Refresh Kakao Login with RefreshTokenL \(refreshToken)")
                    do {
                        cipherRefreshToken = try CryptoUtil.makeEncryption(refreshToken.accessToken)
                        UserDefaults.standard.set(cipherRefreshToken, forKey: .accessToken)
                        UserDefaults.standard.set(refreshToken.expiredAt, forKey: .expiredAt)
                        debugPrint("암호화 리프레쉬 토큰 : \(cipherRefreshToken)")
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                }, onFailure: { error in
                    debugPrint(error.localizedDescription)
                }).disposed(by: disposeBag)
        }
    }
    
    /// 네이버 로그인창을 띄우기 위한 메서드
    public func responseNaverLogin() -> Observable<LoginViewReactor.Mutation> {
        return .just(.setNaverLogin(naverLoginInstance.requestThirdPartyLogin()))
    }
    
    
    /// 구글 로그인창을 띄우기 위한 메서드
    public func responseGoogleLogin(to viewController: AnyObject) -> Observable<LoginViewReactor.Mutation> {
        if let loginController = viewController as? LoginViewController {

            return .just(.setGoogleLogin(GIDSignIn.sharedInstance.signIn(with: googleLoginInstance, presenting: loginController, callback: { user, error in
                var chiperToken = ""
                if let user {
                    do {
                        chiperToken = try CryptoUtil.makeEncryption(user.authentication.clientID)
                        UserDefaults.standard.set(chiperToken, forKey: .accessToken)
                        LoginViewStream.event.onNext(.responseGoogleAccessToken(chiperToken))
                    } catch {
                        print(error.localizedDescription)
                    }
                    SignUpViewStream.event.onNext(.requestGoogleLogin(user))
                }
                
                
                if error != nil {
                    // TODO: Google 유저 정보 가져오기 실패시 에러 처리
                    print("Google Login Error : \(error?.localizedDescription)")
                }
            })))
        }
        
        return .empty()
    }
    
    
    /// 애플 로그인창을 띄우기 위한 메서드
    public func responseAppleLogin() -> Observable<LoginViewReactor.Mutation> {
        
        let appleLoginMutation = Observable<LoginViewReactor.Mutation>
            .create { observer in
                let appleLoginProvider = ASAuthorizationAppleIDProvider()
                let loginRequest = appleLoginProvider.createRequest()
                loginRequest.requestedScopes = [.email, .fullName]
                
                let appleLoginController = ASAuthorizationController(authorizationRequests: [loginRequest])
                appleLoginController.delegate = self
                appleLoginController.presentationContextProvider = self
                appleLoginController.performRequests()
                
                return Disposables.create()
            }
            
        
        return appleLoginMutation
    }
    
    
}



extension LoginViewRepository: NaverThirdPartyLoginConnectionDelegate {
    
    /// 네이버 로그인 성공 시 호출되는 메서드
    public func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        var chiperToken = ""
        if let accessToken = naverLoginInstance.accessToken {
            do {
                chiperToken = try CryptoUtil.makeEncryption(accessToken)
                let expiredAt = naverLoginInstance.accessTokenExpireDate
                UserDefaults.standard.set(chiperToken, forKey: .accessToken)
                UserDefaults.standard.set(expiredAt, forKey: .expiredAt)
            } catch {
                print(error.localizedDescription)
            }
            LoginViewStream.event.onNext(.responseNaverAccessToken(chiperToken))
        }
    }
    
    /// 네이버 로그인 토큰 갱신을 하기 위한 메서드
    public func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        if let refreshToken = naverLoginInstance.accessToken {
            do {
                let chiperToken = try CryptoUtil.makeEncryption(refreshToken)
                let expiredAt = naverLoginInstance.accessTokenExpireDate
                UserDefaults.standard.set(chiperToken, forKey: .accessToken)
                UserDefaults.standard.set(expiredAt, forKey: .expiredAt)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// 네이버 로그아웃 시 호출 되는 메서드
    public func oauth20ConnectionDidFinishDeleteToken() {
        // TODO: 마이페이지 구현에서 로그아웃 버튼 클릭시 호출 되도록 구현
    }
    
    /// 네이버 로그인 실패 시 호출되는 메서드
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("Naver Login Error: \(error)")
    }
}


extension LoginViewRepository: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    
    /// 애플 로그인 성공시 호출되는 메서드
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
    }
    
    /// 애플 로그인 모달창을 호출하기 위한 메서드
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.keywindow ?? ASPresentationAnchor()
    }
        
    /// 애플 로그인 실패시 호출되는 메서드
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login Error: \(error)")
    }
    
}
