//
//  SignUpViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import Foundation

import ReactorKit
import KakaoSDKUser
import KakaoSDKAuth
import RxKakaoSDKAuth
import RxKakaoSDKUser

public protocol SignUpViewRepo {
    var disposeBag: DisposeBag { get }
    func responseKakaoProfile() -> Observable<SignUpViewReactor.Mutation>
}


public final class SignUpViewRepository: SignUpViewRepo {
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    public func responseKakaoProfile() -> Observable<SignUpViewReactor.Mutation> {
        UserApi.shared.rx.me()
            .map { user in
                var scopes = [String]()
                if (user.kakaoAccount?.profileNeedsAgreement == true) { scopes.append("profile") }
                if (user.kakaoAccount?.emailNeedsAgreement == true) { scopes.append("account_email") }
                if (user.kakaoAccount?.birthdayNeedsAgreement == true) { scopes.append("birthday") }
                if (user.kakaoAccount?.birthyearNeedsAgreement == true) { scopes.append("birthyear") }
                if (user.kakaoAccount?.genderNeedsAgreement == true) { scopes.append("gender") }
                if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) { scopes.append("phone_number") }
                
                return user
            }.retry(when: AuthApiCommon.shared.rx.incrementalAuthorizationRequired())
            .subscribe(onSuccess: { user in
                print("success User data: \(user)")
            }, onFailure: { error in
                print("Failure User Error: \(error)")
            }).disposed(by: disposeBag)
        return .empty()
    }
    
}
