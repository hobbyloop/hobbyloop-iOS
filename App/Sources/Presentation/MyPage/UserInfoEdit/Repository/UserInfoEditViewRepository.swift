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
import UIKit

public protocol UserInfoEditViewRepo {
    var networkService: AccountClientService { get }
    var imageService: ImageClientService { get }
    func getUserInfo() -> Observable<UserInfoEditViewReactor.Mutation>
    func issueVerificationID(phoneNumber: String) -> Observable<UserInfoEditViewReactor.Mutation>
    func verifyPhoneNumber(authCode: String, verificationID: String) -> Observable<UserInfoEditViewReactor.Mutation>
    func updateUserInfo(name: String, nickname: String, birthday: String, phoneNumber: String, profileImage: UIImage?) -> Observable<UserInfoEditViewReactor.Mutation>
    func fetchImage(url: URL) -> Observable<UserInfoEditViewReactor.Mutation>
}

public final class UserInfoEditViewRepository: UserInfoEditViewRepo {
    
    public var networkService: AccountClientService = AccountClient.shared
    public var imageService: ImageClientService = ImageClient.shared
    
    public func getUserInfo() -> Observable<UserInfoEditViewReactor.Mutation> {
        return self.networkService.getUserInfo()
            .asObservable()
            .catch { _ in
                // TODO: 에러 핸들링
                return .empty()
            }
            .flatMap { [weak self] userInfo -> Observable<UserInfoEditViewReactor.Mutation> in
                guard let self else { return .empty() }
                let birthdayArr = userInfo.birthday.components(separatedBy: "-")
                var imageObservable: Observable<UserInfoEditViewReactor.Mutation> = .empty()
                
                if let profileImageUrl = userInfo.profileImageUrl {
                    imageObservable = self.fetchImage(url: profileImageUrl)
                }
                
                return .merge(
                    .of(
                        .setName(userInfo.name),
                        .setNickname(userInfo.nickname),
                        .setPhoneNumber(userInfo.phoneNumber.replacingOccurrences(of: "-", with: "")),
                        .setBirthday(birthdayArr[0] + "년 " + birthdayArr[1] + "월 " + birthdayArr[2] + "일"),
                        .setProfileImageUrl(userInfo.profileImageUrl),
                        .setIsValidPhoneNumber(true)
                    ),
                    imageObservable
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
    
    public func updateUserInfo(name: String, nickname: String, birthday: String, phoneNumber: String, profileImage: UIImage?) -> Observable<UserInfoEditViewReactor.Mutation> {
        return self.networkService.updateUserInfo(
            name: name,
            nickname: nickname,
            birthday: birthday
                .replacingOccurrences(of: "년 ", with: "-")
                .replacingOccurrences(of: "월 ", with: "-")
                .replacingOccurrences(of: "일", with: ""),
            phoneNumber: phoneNumber.withHypen,
            profileImage: profileImage
        )
        .asObservable()
        .catch { _ in
            // TODO: 에러 핸들링
            return .empty()
        }
        .map {
            return .userInfoSubmitted
        }
    }
    
    public func fetchImage(url: URL) -> Observable<UserInfoEditViewReactor.Mutation> {
        return self.imageService.fetchHPImage(url: url)
            .asObservable()
            .catch { _ in
                // TODO: 에러 핸들링
                return .empty()
            }
            .map { image in
                return .setProfileImage(image)
            }
    }
}
