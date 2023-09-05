//
//  LoginViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/09.
//

import Foundation

import HPCommon
import HPExtensions
import HPNetwork
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
    
    var networkService: APIService { get }
    var naverLoginInstance: NaverThirdPartyLoginConnection { get }
    var googleLoginInstance: GIDConfiguration { get }
    
    /// 카카오 로그인을 위한 implementation
    func responseKakaoLogin() -> Observable<LoginViewReactor.Mutation>
    func responseKakaoWebLogin() -> Observable<LoginViewReactor.Mutation>
    func resultKakaoLogin() -> Observable<LoginViewReactor.Mutation>
    
    /// 네이버 로그인을 위한 implementation
    func responseNaverLogin() -> Observable<LoginViewReactor.Mutation>
    
    /// 구글 로그인을 위한 implementation
    func responseGoogleLogin(to viewController: AnyObject) -> Observable<LoginViewReactor.Mutation>
    
    /// 애플 로그인을 위한 implementation
    func responseAppleLogin() -> Observable<LoginViewReactor.Mutation>
    
}


public final class LoginViewRepository: NSObject, LoginViewRepo {
    public var networkService: HPNetwork.APIService = APIClient.shared
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    public let naverLoginInstance: NaverThirdPartyLoginConnection = NaverThirdPartyLoginConnection.getSharedInstance()
    public let googleLoginInstance: GIDConfiguration = GIDConfiguration(clientID: "565615287672-emohfjcbdultg158jdvjrbkuqsgbps8a.apps.googleusercontent.com")
    
    
    public override init() {
        super.init()
        self.naverLoginInstance.delegate = self
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
                
                let kakaoAuthMutation = Observable<LoginViewReactor.Mutation>
                    .create { observer in
                        self.networkService.requestToAuthentication(AccountRouter.getAccessToken(type: AccountType.kakao, token: accessToken.accessToken)) { authToken in
                            observer.onNext(.setAccessToken(authToken))
                            
                        }
                        return Disposables.create()
                    }
                return kakaoAuthMutation
            }
    }
    
    
    /// 카카오 웹로그인 창을 띄우기 위한 메서드
    /// - note: 로그인이 필요한 경우 및 사용자가 카카오톡이 깔려 있지 않는 경우 웹 브라우저를 띄운다.
    /// - parameters: none Parameters
    public func responseKakaoWebLogin() -> RxSwift.Observable<LoginViewReactor.Mutation> {
        return UserApi.shared.rx.loginWithKakaoAccount()
            .asObservable()
            .flatMap { accessToken -> Observable<LoginViewReactor.Mutation> in
                let kakaoWebAuthMutation = Observable<LoginViewReactor.Mutation>
                    .create { observer in
                        self.networkService.requestToAuthentication(AccountRouter.getAccessToken(type: AccountType.kakao, token: accessToken.accessToken)) { authToken in
                            observer.onNext(.setAccessToken(authToken))
                            observer.onNext(.setLoading(false))
                        }
                        return Disposables.create()
                    }
                return kakaoWebAuthMutation
            }
    }
    
    /// 네이버 로그인창을 띄우기 위한 메서드
    public func responseNaverLogin() -> Observable<LoginViewReactor.Mutation> {
        naverLoginInstance.resetToken()
        return .just(.setNaverLogin(naverLoginInstance.requestThirdPartyLogin()))
    }
    
    
    /// 구글 로그인창을 띄우기 위한 메서드
    public func responseGoogleLogin(to viewController: AnyObject) -> Observable<LoginViewReactor.Mutation> {
        if let loginController = viewController as? LoginViewController {
            
            return .just(.setGoogleLogin(GIDSignIn.sharedInstance.signIn(with: googleLoginInstance, presenting: loginController, callback: { [weak self] user, error in
                if let user {
                    self?.networkService.requestToAuthentication(AccountRouter.getAccessToken(type: .google, token: user.authentication.accessToken), completion: { authToken in
                        LoginViewStream.event.onNext(.responseAccessToken(token: authToken))
                    })
                } else {
                    debugPrint(error?.localizedDescription)
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
        if let accessToken = naverLoginInstance.accessToken {
            
            // TODO: Naver Access Token 발급시 JWT 발급 요청 및 Mutation 방출
            self.networkService.requestToAuthentication(AccountRouter.getAccessToken(type: .naver, token: accessToken)) { authToken in
                LoginViewStream.event.onNext(.responseAccessToken(token: authToken))
            }
        }
    }
    
    /// 네이버 로그인 토큰 갱신을 하기 위한 메서드
    public func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() { }
    
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
        
        var chiperToken = ""
        var chiperId = ""
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            guard let token = appleIDCredential.identityToken,
                  let givenName = appleIDCredential.fullName?.givenName,
                  let familyName = appleIDCredential.fullName?.familyName,
                  let authorizationCode = appleIDCredential.authorizationCode,
                  let code = String(bytes: authorizationCode, encoding: .utf8),
                  let identityToken = String(bytes: token, encoding: .utf8) else { return }
            let userIdentifier = appleIDCredential.user
            
            //TODO: Apple Login Server API 구현시 Code 추가
            debugPrint("appleLogin identityToken: \(identityToken)")
            self.networkService.requestToAuthentication(AccountRouter.getAccessToken(type: .apple, token: identityToken)) { authToken in
                
            }
            let resultName = "\(familyName)\(givenName)"
            SignUpViewStream.event.onNext(.requestAppleLogin(resultName))
        default:
            break
            
        }
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
