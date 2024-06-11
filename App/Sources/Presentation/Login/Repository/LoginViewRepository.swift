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
import HPDomain
import ReactorKit
import KakaoSDKUser
import KakaoSDKAuth
import RxKakaoSDKUser
import RxKakaoSDKAuth
import NaverThirdPartyLogin
import GoogleSignIn
import AuthenticationServices

public protocol LoginViewRepo {
    var disposeBag: DisposeBag { get }
    
    var networkService: AccountClientService { get }
    var naverLoginInstance: NaverThirdPartyLoginConnection { get }
    var googleLoginInstance: GIDConfiguration { get }
    
    /// 카카오 로그인을 위한 implementation
    func responseKakaoLogin() -> Observable<OAuthToken>
    func responseKakaoWebLogin() -> Observable<OAuthToken>
    func resultKakaoLogin() -> Observable<LoginViewReactor.Mutation>
    
    /// 네이버 로그인을 위한 implementation
    func responseNaverLogin() -> Observable<LoginViewReactor.Mutation>
    
    /// 구글 로그인을 위한 implementation
    func responseGoogleUser(to viewController: AnyObject) -> Observable<GIDGoogleUser>
    func responseGoogleLogin(to viewController: AnyObject) -> Observable<LoginViewReactor.Mutation>
    
    /// 애플 로그인을 위한 implementation
    func responseAppleLogin() -> Observable<LoginViewReactor.Mutation>
    
}


public final class LoginViewRepository: NSObject, LoginViewRepo {
    public var networkService: HPNetwork.AccountClientService = AccountClient.shared
    
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
    public func resultKakaoLogin() -> Observable<LoginViewReactor.Mutation> {
        let loginObservable = UserApi.isKakaoTalkLoginAvailable() ? responseKakaoLogin() : responseKakaoWebLogin()
        return loginObservable
            .take(1)
            .catch { error in
                print("kakao error: \(error)")
                return Observable.empty()
            }
            .flatMap { accessToken -> Observable<LoginViewReactor.Mutation> in
                self.networkService.requestUserToken(account: AccountType.kakao, accessToken: accessToken.accessToken)
                    .asObservable()
                    .flatMap { (data: TokenResponseBody) ->
                        Observable<LoginViewReactor.Mutation> in
                        
                        .just(.setAccessToken(.kakao, data))
                    }
            }
    }
    
    /// 카카오 사용자의 AccessToken 값을 이용하여 JWT 토큰 값을 발급하기 위한 메서드
    ///  - note: 카카오 서버에서 발급 받은 AccessToken 값을 통해 자체 서버의 AccessToken, RefreshToken 값을 발급 받기위한 Method
    ///  - parameters: Observable<OAuthToken>
    public func responseKakaoLogin() -> Observable<OAuthToken> {
        return UserApi.shared.rx.loginWithKakaoTalk()
            .asObservable()
            
    }
    
    
    /// 카카오 사용자의 AccessToken 값을 이용하여 JWT 토큰 값을 발급하기 위한 메서드, 웹(safariViewController) 로그인 시 호출
    ///  - note: 카카오 서버에서 발급 받은 AccessToken 값을 통해 자체 서버의 AccessToken, RefreshToken 값을 발급 받기위한 Method
    ///  - parameters: Observable<OAuthToken>
    public func responseKakaoWebLogin() -> Observable<OAuthToken> {
        return UserApi.shared.rx.loginWithKakaoAccount()
            .asObservable()
    }
    
    /// 네이버 로그인창을 띄우기 위한 메서드
    /// - note: 사용자의 Action을 전달받아 네이버 로그인창을 띄운다.
    /// - parameters: none Parameters
    public func responseNaverLogin() -> Observable<LoginViewReactor.Mutation> {
        naverLoginInstance.resetToken()
        return .just(.setNaverLogin(naverLoginInstance.requestThirdPartyLogin()))
    }
    
    /// 구글 GIDGoogleUser Entity 값을 관찰하기 위한 메서드
    /// - note: GIDGoogleUser Entity 이벤트를 방출 시켜 Return 하도록 한다.
    /// - parameters: Observable<GIDGoogleUser>
    public func responseGoogleUser(to viewController: AnyObject) -> Observable<GIDGoogleUser> {
        return Observable.create { observer in
            if let viewController = viewController as? LoginViewController {
                GIDSignIn.sharedInstance.signIn(with: self.googleLoginInstance, presenting: viewController) { user, error in
                    if let user = user {
                        observer.onNext(user)
                    }
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    
    /// 구글 사용자의 AccessToken 값을 이용하여 JWT 토큰 값을 발급하기 위한 메서드
    /// - note: 구글 서버에서 발급 받은 AccessToken 값을 통해 자체 서버의 AccessToken, RefreshToken 값을 발급 받기위한 Method
    /// - parameters: Observable<LoginViewReactor.Mutation>
    public func responseGoogleLogin(to viewController: AnyObject) -> Observable<LoginViewReactor.Mutation> {
        responseGoogleUser(to: viewController)
            .flatMap { [weak self] user -> Observable<LoginViewReactor.Mutation> in
                guard let self = `self` else { return .empty() }
                print("google token: \(user.authentication.accessToken)")
                return self.networkService.requestUserToken(account: .google, accessToken: user.authentication.accessToken)
                    .asObservable()
                    .flatMap { (data: TokenResponseBody) -> Observable<LoginViewReactor.Mutation> in
                            .just(.setAccessToken(.google, data))
                    }
            }
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
            self.networkService.requestUserToken(account: .naver, accessToken: accessToken)
                .subscribe(onSuccess: { data in
                    LoginViewStream.event.onNext(.responseAccessToken(token: data))
                }).disposed(by: disposeBag)
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
        LoginViewStream.event.onNext(.fail)
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
            
            //TODO: Server Response 변경으로 인한 로직 변경 반영 예정
            debugPrint("appleLogin identityToken: \(identityToken)")
            UserDefaults.standard.set(userIdentifier, forKey: .accessId)
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
