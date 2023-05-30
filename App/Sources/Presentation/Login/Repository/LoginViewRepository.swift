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


public protocol LoginDelegate: AnyObject {
    func failureKakaoLogin() -> Void
    func successKakoLogin() -> Void
}

public protocol LoginViewRepo {
    var disposeBag: DisposeBag { get }
    var delegate: LoginDelegate? { get set }
    func responseKakaoLogin() -> Void
    func isExpiredKakaoToken() -> Observable<LoginViewReactor.Mutation>
}


public final class LoginViewRepository: LoginViewRepo {
    
    public var disposeBag: DisposeBag = DisposeBag()
    public weak var delegate: LoginDelegate?
    
    /// 카카오 에서 발급 받은 Access Token  값이 유효한지 확인하는 메서드
    /// - note: suceess에 떨어지는 경우 accessToken 값이 유효 한 경우, 혹은 필요시 Access Token 값을 갱신 해줌
    /// - parameters: none Parameters
    public func isExpiredKakaoToken() -> Observable<LoginViewReactor.Mutation> {
        if (AuthApi.hasToken()) {
            UserApi.shared.rx.accessTokenInfo()
                .subscribe(onSuccess: { _ in
                    print("Kakao Login Token Success")
                }, onFailure: { error in
                    if let sdkError = error as? SdkError,
                       sdkError.isInvalidTokenError() == true {
                        self.responseKakaoLogin()
                    }
                }).disposed(by: disposeBag)
            
            
        }
        return .empty()
    }
    
    
    /// 카카오 로그인창 창을 띄우기 위한 메서드
    ///  - note: 로그인이 필요한 경우 일때 호출 해야하는 메서드
    ///  - parameters: none Parameters
    public func responseKakaoLogin() -> Void {
        var cipherToken: String = ""
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext: { accessToken in
                    print("success Kakao Login with AccessToken: \(accessToken)")
                    do {
                        cipherToken = try CryptoUtil.makeEncryption(accessToken.accessToken)
                        self.delegate?.successKakoLogin()
                        print("암호화 토큰 : \(cipherToken)")
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }).disposed(by: disposeBag)
        }
        
    }
        
}



