//
//  SignUpViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import Foundation

import HPDomain
import HPCommon
import HPExtensions
import ReactorKit
import RxSwift
import KakaoSDKUser
import GoogleSignIn


public enum SignUpViewStream: HPStreamType {
    public enum Event {
        case requestAppleLogin(_ profie: String)
    }
}


public enum HPGender: String, Equatable {
    case male
    case female
    case none
    
    func getGenderType() -> String {
        switch self {
        case .male:
            return "남자"
        case .female:
            return "여자"
        case .none:
            return ""
        }
    }
}



public final class SignUpViewReactor: Reactor {
    
    // MARK: Property
    public var initialState: State
    private var signUpRepository: SignUpViewRepo
    public var accountType: AccountType
    
    public enum Action {
        case viewDidLoad
        case didTapGenderButton(HPGender)
        case didTapAuthCodeButton
        case didTapCertificationButton
        case didTapCreateUserButton(String, String, String, String, String)
        case updateToName(String)
        case updateToNickName(String)
        case updateToBirthDay(String)
        case updateToPhoneNumber(String)
        case didChangePhoneNumber
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setKakaoUserEntity(User)
        case setUserGender(HPGender)
        case setNaverUserEntity(NaverAccount)
        case setCertificationState(Bool)
        case setAppleUserFullName(String)
        case setUserName(String)
        case setUserNickName(String)
        case setUserBirthDay(String)
        case setUserPhoneNumber(String)
        case setCreateUserInfo(UserAccount)
    }
    
    public struct State {
        var isLoading: Bool
        @Pulse var kakaoUserEntity: User?
        @Pulse var naverUserEntity: NaverAccount?
        var userAccountEntity: UserAccount?
        var userGender: HPGender
        var ceritifcationState: Bool
        var userName: String
        var userNickName: String
        var userBirthDay: String
        var applefullName: String
        var isVaildationPhoneNumber: Bool
        var phoneNumber: String
    }
    
    public init(signUpRepository: SignUpViewRepo, accountType: AccountType) {
        self.signUpRepository = signUpRepository
        self.accountType = accountType
        self.initialState = State(
            isLoading: false,
            kakaoUserEntity: nil,
            naverUserEntity: nil,
            userAccountEntity: nil,
            userGender: .none,
            ceritifcationState: false,
            userName: "",
            userNickName: "",
            userBirthDay: "",
            applefullName: "",
            isVaildationPhoneNumber: false,
            phoneNumber: ""
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
    
        
        switch action {
        case .viewDidLoad:
            var requestProfile = Observable<Mutation>.empty()
            if accountType == .kakao {
                requestProfile = signUpRepository.responseKakaoProfile()
            } else if accountType == .naver {
                requestProfile = signUpRepository.responseNaverProfile()
            }
            
            return .concat(
                .just(.setLoading(true)),
                requestProfile,
                .just(.setLoading(false))
            )
        case let .updateToName(userName):
            return .just(.setUserName(userName))
            
        case let .updateToNickName(userNickName):
            return .just(.setUserNickName(userNickName))
            
        case let .updateToBirthDay(userBirthDay):
            return .just(.setUserBirthDay(userBirthDay))
            
        case let .didTapGenderButton(gender):
        
            return .just(.setUserGender(gender))
            
        case .didTapAuthCodeButton:
            
            return .empty()
            
        case .didTapCertificationButton:
            
            guard self.currentState.ceritifcationState else { return .empty() }
            return .just(.setCertificationState(self.currentState.ceritifcationState))
            
        case let .didTapCreateUserButton(name, nickName, gender, birthDay, phoneNumber):
            
            return .concat(
                .just(.setLoading(true)),
                signUpRepository.createUserInformation(name: name, nickname: nickName, gender: gender, birthDay: birthDay, phoneNumber: phoneNumber),
                .just(.setLoading(false))
            )
            
        case let .updateToPhoneNumber(phoneNumber):
            return .just(.setUserPhoneNumber(phoneNumber))
            
            
        case .didChangePhoneNumber:
            
            return .just(.setCertificationState(!self.currentState.ceritifcationState))
        }
    }
    
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        
        let appleNickNameUpdate = SignUpViewStream.event.flatMap { [weak self] event in
            self?.requestAppleUserProfile(from: event) ?? .empty()
        }
        
        return Observable.of(mutation, appleNickNameUpdate).merge()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .setUserName(userName):
            newState.userName = userName
            
        case let .setUserNickName(userNickName):
            newState.userNickName = userNickName
            
        case let .setUserBirthDay(userBirthDay):
            newState.userBirthDay = userBirthDay
            
        case let .setKakaoUserEntity(kakaoEntity):
            newState.kakaoUserEntity = kakaoEntity
            
        case let .setNaverUserEntity(naverEntity):
            newState.naverUserEntity = naverEntity
            
        case let .setCertificationState(certificationState):
            newState.ceritifcationState = certificationState
            
        case let .setAppleUserFullName(fullName):
            newState.applefullName = fullName
            
        case let .setUserGender(gender):
            newState.userGender = gender
            
        case let .setCreateUserInfo(accountInfo):
            newState.userAccountEntity = accountInfo
            
        case let .setUserPhoneNumber(phoneNumber):
            newState.phoneNumber = phoneNumber
            newState.isVaildationPhoneNumber = phoneNumber.isValidPhoneNumber()
        }
        
        return newState
    }
}



public extension SignUpViewReactor {
    
    
    func requestAppleUserProfile(from event: SignUpViewStream.Event) -> Observable<Mutation> {
        switch event {
        case let .requestAppleLogin(fullName):
            return .just(.setAppleUserFullName(fullName))
        }
    }
    
}
