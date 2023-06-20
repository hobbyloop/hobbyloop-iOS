//
//  SignUpViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import Foundation

import ReactorKit
import RxCocoa
import KakaoSDKUser
import NaverThirdPartyLogin
import RxKakaoSDKUser
import HPNetwork
import HPDomain

public protocol SignUpViewRepo {
    var disposeBag: DisposeBag { get }
    var APIService: APIService { get }
    var naverLoginInstance: NaverThirdPartyLoginConnection { get }
    func responseKakaoProfile() -> Observable<SignUpViewReactor.Mutation>
    func responseNaverProfile() -> Observable<SignUpViewReactor.Mutation>
}


public final class SignUpViewRepository: SignUpViewRepo {
    
    public var disposeBag: DisposeBag = DisposeBag()
    public var APIService: APIService = APIClient.shared
    public var naverLoginInstance: NaverThirdPartyLoginConnection = NaverThirdPartyLoginConnection.getSharedInstance()
    
    public init(APIService: APIService) {
        self.APIService = APIService
    }
    
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
        
        if !naverLoginInstance.isValidAccessTokenExpireTimeNow() {
            //TODO: 토큰이 만료될시 추후 처리 추가
            return .empty()
        } else {
            return APIService.request(NaverAccount.self, AccountRouter.getNaverUserInfo)
                .asObservable()
                .flatMap { (data: NaverAccount) -> Observable<SignUpViewReactor.Mutation> in
                    return .just(.setNaverUserEntity(data))
                }
        }

    }
}
