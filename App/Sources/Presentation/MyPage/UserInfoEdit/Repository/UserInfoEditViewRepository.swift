//
//  UserInfoEditViewRepository.swift
//  Hobbyloop
//
//  Created by 김남건 on 7/6/24.
//

import Foundation
import HPNetwork
import RxSwift
import HPDomain

public protocol UserInfoEditViewRepo {
    var networkService: AccountClientService { get }
    func getUserInfo() -> Observable<UserInfoEditViewReactor.Mutation>
    func issueVerificationID(phoneNumber: String) -> Observable<UserInfoEditViewReactor.Mutation>
    func verifyPhoneNumber(authCode: String, verificationID: String) -> Observable<UserInfoEditViewReactor.Mutation>
}

public final class UserInfoEditViewRepository: UserInfoEditViewRepo {
    
    public var networkService: AccountClientService = AccountClient.shared
    
    public func getUserInfo() -> Observable<UserInfoEditViewReactor.Mutation> {
        return self.networkService.getUserInfo()
            .asObservable()
            .catch { _ in
                // TODO: 에러 핸들링
                return .empty()
            }
            .flatMap { userInfo -> Observable<UserInfoEditViewReactor.Mutation> in
                return .of(
                    .setName(userInfo.name),
                    .setNickname(userInfo.nickname),
                    .setPhoneNumber(userInfo.phoneNumber.replacingOccurrences(of: "-", with: "")),
                    .setBirthday(userInfo.birthday.replacingOccurrences(of: "-", with: ".")),
                    .setProfileImageUrl(userInfo.profileImageUrl)
                )
            }
    }
    
    public func issueVerificationID(phoneNumber: String) -> Observable<UserInfoEditViewReactor.Mutation> {
        return self.networkService.issueVerificationID(phoneNumber: phoneNumber.withHypen)
            .asObservable()
            .catch { _ in
                // TODO: 에러 핸들링
                return .empty()
            }
            .flatMap { verificationID in
                return Observable.concat([
                    .just(.setVerificationID(verificationID)),
                    .just(.setShowsAuthCodeView(true))
                ])
            }
    }
    
    public func verifyPhoneNumber(authCode: String, verificationID: String) -> Observable<UserInfoEditViewReactor.Mutation> {
        return self.networkService.verifyPhoneNumber(authCode: authCode, verificationID: verificationID)
            .asObservable()
            .catch { _ in
                // TODO: 에러 핸들링
                return .empty()
            }
            .flatMap {
                return Observable.concat([
                    .just(.setIsValidPhoneNumber(true))
                ])
            }
    }
    
    
}
