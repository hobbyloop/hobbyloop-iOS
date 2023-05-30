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
import HPExtensions

public protocol LoginViewRepo {
    var disposeBag: DisposeBag { get }
    func responseKakaoLogin() -> Observable<LoginViewReactor.Mutation>
    func responseRefreshKakaoToken() -> Void
    func isExpiredKakaoToken() -> Void
}


public final class LoginViewRepository: LoginViewRepo {
    
    public var disposeBag: DisposeBag = DisposeBag()
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
    
    
    /// 카카오 로그인창 창을 띄우기 위한 메서드
    ///  - note: 로그인이 필요한 경우 일때 호출 해야하는 메서드
    ///  - parameters: none Parameters
    public func responseKakaoLogin() -> Observable<LoginViewReactor.Mutation> {
        var cipherToken: String = ""
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext: { accessToken in
                    print("success Kakao Login with AccessToken: \(accessToken)")
                    do {
                        cipherToken = try CryptoUtil.makeEncryption(accessToken.accessToken)
                        UserDefaults.standard.set(cipherToken, forKey: .accessToken)
                        UserDefaults.standard.set(accessToken.expiredAt, forKey: .expiredAt)
                        debugPrint("암호화 토큰 : \(cipherToken)")
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                    
                }).disposed(by: disposeBag)
        }
        
        return .just(.setKakaoAccessToken(cipherToken))
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
        
}



