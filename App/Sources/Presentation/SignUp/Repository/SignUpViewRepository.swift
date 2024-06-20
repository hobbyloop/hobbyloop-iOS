//
//  SignUpViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import Foundation

import HPNetwork
import HPDomain
import ReactorKit
import KakaoSDKUser
import RxKakaoSDKUser
import NaverThirdPartyLogin

public protocol SignUpViewRepo {
    var disposeBag: DisposeBag { get }
    var networkService: AccountClientService { get }
    var naverLoginInstance: NaverThirdPartyLoginConnection { get }
    func responseKakaoProfile() -> Observable<SignUpViewReactor.Mutation>
    func responseNaverProfile() -> Observable<SignUpViewReactor.Mutation>
    func createUserInformation(name: String, nickname: String, gender: String, birthDay: String, phoneNumber: String) -> Observable<SignUpViewReactor.Mutation>
    func issueVerificationID(phoneNumber: String) -> Observable<SignUpViewReactor.Mutation>
    func verifyPhoneNumber(authCode: String, verificationID: String) -> Observable<SignUpViewReactor.Mutation>
}


public final class SignUpViewRepository: SignUpViewRepo {
    
    public var disposeBag: DisposeBag = DisposeBag()
    public var networkService: AccountClientService = AccountClient.shared
    public var naverLoginInstance: NaverThirdPartyLoginConnection = NaverThirdPartyLoginConnection.getSharedInstance()
    
    public init() { }
    
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
            return self.networkService.requestNaverUserInfo(header: naverLoginInstance.tokenType, accessToken: naverLoginInstance.accessToken)
                .asObservable()
                .flatMap { (data: NaverAccount) -> Observable<SignUpViewReactor.Mutation> in
                    .just(.setNaverUserEntity(data))
                }
        }

    }
    
    /// 자체 서버에 사용자 등록 메서드
    /// - note: 사용자에게 필요한 프로필 정보를 받으며 서버에게 등록하기 위한 메서드
    /// - parameters:
    ///   - name 사용자 이름
    ///   - nickname 사용자 닉네임
    ///   - gender 사용자 성별
    ///   - birth 사용자 출생년도
    ///   - phoneNumber 사용자 핸드폰 번호
    public func createUserInformation(name: String, nickname: String, gender: String, birthDay: String, phoneNumber: String) -> Observable<SignUpViewReactor.Mutation> {
        return self.networkService.createUserInfo(
            birthDay: birthDay,
            gender: gender,
            name: name,
            nickname: nickname,
            phoneNumber: phoneNumber
        ).asObservable().flatMap { (data: UserAccount) -> Observable<SignUpViewReactor.Mutation> in
            .just(.setCreateUserInfo(data))
        }
    }
    
    public func issueVerificationID(phoneNumber: String) -> Observable<SignUpViewReactor.Mutation> {
        return self.networkService.issueVerificationID(phoneNumber: phoneNumber.withHypen)
            .asObservable()
            .catch { _ in
                return .empty()
            }
            .flatMap { verificationID in
                return Observable.concat([
                    .just(SignUpViewReactor.Mutation.setShowAuthCodeView(true)),
                    .just(SignUpViewReactor.Mutation.setVerificationID(verificationID))
                ])
            }
    }
    
    public func verifyPhoneNumber(authCode: String, verificationID: String) -> Observable<SignUpViewReactor.Mutation> {
        return self.networkService.verifyPhoneNumber(authCode: authCode, verificationID: verificationID)
            .asObservable()
            .catch { _ in
                return .empty()
            }
            .map {
                .validatePhoneNumber
            }
    }
}
