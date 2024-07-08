//
//  UserInfoEditViewReactor.swift
//  Hobbyloop
//
//  Created by 김남건 on 7/6/24.
//

import Foundation
import ReactorKit
import UIKit

public final class UserInfoEditViewReactor: Reactor {
    public var initialState: State = State()
    public let repository: UserInfoEditViewRepo
    
    public struct State {
        var isLoading: Bool = false
        var name: String = ""
        var nickname: String = ""
        var showsBirthdayPicker: Bool = false
        var birthday: String = ""
        var phoneNumber: String = ""
        var profileImageUrl: URL? = nil
        var profileImage: UIImage? = nil
        var showsAuthCodeView: Bool = false
        var verificationID: String = ""
        var authCode: String = ""
        var isValidPhoneNumber: Bool = true
    }
    
    public enum Action {
        case viewDidLoad
        case updateName(String)
        case updateNickname(String)
        case updateBirthday(String)
        case updatePhoneNumber(String)
        case tapIssueAuthCodeButton
        case updateAuthCode(String)
        case tapVerifyAuthCodeButton
        case tapUpdateButton
        case tapBirthdayPickerButton
        case tapBackgroundView
        case updateProfileImage(UIImage)
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setName(String)
        case setNickname(String)
        case setBirthday(String)
        case setPhoneNumber(String)
        case setProfileImageUrl(URL?)
        case setProfileImage(UIImage)
        case setShowsAuthCodeView(Bool)
        case setVerificationID(String)
        case setAuthCode(String)
        case setIsValidPhoneNumber(Bool)
        case setShowsBirthdayPicker(Bool)
    }
    
    init(repository: UserInfoEditViewRepo) {
        self.repository = repository
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .concat([
                .just(.setLoading(true)),
                repository.getUserInfo(),
                .just(.setLoading(false))
            ])
        case .updateName(let name):
            return .just(.setName(name))
        case .updateNickname(let nickname):
            return .just(.setNickname(nickname))
        case .updateBirthday(let birthday):
            return .just(.setBirthday(birthday))
        case .updatePhoneNumber(let phoneNumber):
            return .of(
                .setPhoneNumber(phoneNumber),
                .setIsValidPhoneNumber(false),
                .setVerificationID(""),
                .setShowsAuthCodeView(false)
            )
        case .tapIssueAuthCodeButton:
            return .concat([
                .just(.setIsValidPhoneNumber(false)),
                .just(.setLoading(true)),
                repository.issueVerificationID(phoneNumber: currentState.phoneNumber),
                .just(.setLoading(false))
            ])
        case .updateAuthCode(let authCode):
            return .just(.setAuthCode(authCode))
        case .tapVerifyAuthCodeButton:
            return .concat([
                .just(.setLoading(true)),
                repository.verifyPhoneNumber(authCode: currentState.authCode, verificationID: currentState.verificationID),
                .just(.setLoading(false))
            ])
        case .tapUpdateButton:
            // TODO: 정보 수정 버튼 클릭 기능 구현
            return .empty()
        case .tapBirthdayPickerButton:
            return .just(.setShowsBirthdayPicker(true))
        case .tapBackgroundView:
            return .just(.setShowsBirthdayPicker(false))
        case .updateProfileImage(let image):
            return .just(.setProfileImage(image))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .setName(let name):
            newState.name = name
        case .setNickname(let nickname):
            newState.nickname = nickname
        case .setBirthday(let birthday):
            newState.birthday = birthday
        case .setPhoneNumber(let phoneNumber):
            newState.phoneNumber = phoneNumber
        case .setProfileImageUrl(let url):
            newState.profileImageUrl = url
        case .setProfileImage(let image):
            newState.profileImage = image
        case .setShowsAuthCodeView(let showsAuthCodeView):
            newState.showsAuthCodeView = showsAuthCodeView
        case .setVerificationID(let verificationID):
            newState.verificationID = verificationID
        case .setAuthCode(let authCode):
            newState.authCode = authCode
        case .setIsValidPhoneNumber(let isValidPhoneNumber):
            newState.isValidPhoneNumber = isValidPhoneNumber
        case .setShowsBirthdayPicker(let showsBirthdayPicker):
            newState.showsBirthdayPicker = showsBirthdayPicker
        }
        
        return newState
    }
}
