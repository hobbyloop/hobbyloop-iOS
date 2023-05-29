//
//  LoginViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/09.
//

import Foundation

import ReactorKit
import KakaoSDKUser
import KakaoSDKAuth
import RxKakaoSDKUser
import RxKakaoSDKAuth
import KakaoSDKCommon
import HPCommon

public protocol LoginViewRepo {
    var disposeBag: DisposeBag { get }
    func responseKakaoLogin() -> Observable<LoginViewReactor.Mutation>
    func isExpiredKakaoToken() -> Observable<LoginViewReactor.Mutation>
    func failureKakaoLogin() -> Void
    func successKakoLogin() -> Void
}


public final class LoginViewRepository: LoginViewRepo {
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    
    public func isExpiredKakaoToken() -> Observable<LoginViewReactor.Mutation> {
        if (AuthApi.hasToken()) {
            UserApi.shared.rx.accessTokenInfo()
                .subscribe(onSuccess: { _ in
                    print("Kakao Login Token Success")
                    self.successKakoLogin()
                }, onFailure: { error in
                    if let sdkError = error as? SdkError,
                       sdkError.isInvalidTokenError() == true {
                        self.failureKakaoLogin()
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    public func responseKakaoLogin() -> Observable<LoginViewReactor.Mutation> {
        var cipherToken: String = ""
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext: { accessToken in
                    print("success Kakao Login with AccessToken: \(accessToken)")
                    do {
                        cipherToken = try CryptoUtil.makeEncryption(accessToken.accessToken)
                        print("암호화 토큰 : \(cipherToken)")
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }).disposed(by: disposeBag)
        }
        
        return .just(.setKakaoAccessToken(cipherToken))
    }
    
    /// 카카오 로그인 성공시 호출 되는 메서드
    public func successKakoLogin() {
        <#code#>
    }
    
    /// 카카오 로그인 실패시 호출 되는 메서드
    public func failureKakaoLogin() {
        <#code#>
    }
        
}



