//
//  SignUpViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import Foundation

import ReactorKit
import KakaoSDKUser
import RxKakaoSDKUser
import HPNetwork

public protocol SignUpViewRepo {
    var disposeBag: DisposeBag { get }
    func responseKakaoProfile() -> Observable<SignUpViewReactor.Mutation>
    func responseNaverProfile() -> Observable<SignUpViewReactor.Mutation>
}


public final class SignUpViewRepository: SignUpViewRepo {
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    
    /// 카카오 사용자 프로필 조회 메서드
    /// - note: 로그인 성공후 카카오 사용자 프로필 정보 조회 하기 위한 메서드
    /// - parameters: none Parameters
    public func responseKakaoProfile() -> Observable<SignUpViewReactor.Mutation> {
        
       return UserApi.shared.rx.me()
            .asObservable()
            .flatMap { user -> Observable<SignUpViewReactor.Mutation> in
                return .just(.setKakaoUserEntity(user))
            }
    }
    
    
    /// 네이버 사용자 프로필 조회 메서드
    /// - note: 로그인 성공후 네이버 사용자 프로필 정보 조회 하기 위한 메서드
    /// - parameters: none Parameters
    public func responseNaverProfile() -> Observable<SignUpViewReactor.Mutation> {
        return .empty()
    }
}
