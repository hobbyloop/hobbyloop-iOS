//
//  LoginViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/09.
//

import Foundation

import ReactorKit
import KakaoSDKUser
import RxKakaoSDKUser
import KakaoSDKCommon
import HPCommon

public protocol LoginViewRepo {
    var disposeBag: DisposeBag { get }
    func responseKakaoLogin() -> Observable<LoginViewReactor.Mutation>
}


public final class LoginViewRepository: LoginViewRepo {
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    
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
    
}



