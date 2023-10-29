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
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            var requestProfile = Observable<Mutation>.empty()
            print("viewDidLoad SignUp Reactor: \(self.accountType)")
            if accountType == .kakao {
                requestProfile = signUpRepository.responseKakaoProfile()
            } else if accountType == .naver {
                requestProfile = signUpRepository.responseNaverProfile()
            }
            
            return .concat(
                startLoading,
                requestProfile,
                endLoading
            )
        case let .updateToName(userName):
            print("update To Name : \(userName)")
            return .just(.setUserName(userName))
            
        case let .updateToNickName(userNickName):
            return .just(.setUserNickName(userNickName))
            
        case let .updateToBirthDay(userBirthDay):
            return .just(.setUserBirthDay(userBirthDay))
            
        case let .didTapGenderButton(gender):
            let setUserInfoGender = Observable<Mutation>.just(.setUserGender(gender))
            
            return setUserInfoGender
            
        case .didTapAuthCodeButton:
            
            return .empty()
            
        case .didTapCertificationButton:
            
            guard self.currentState.ceritifcationState else { return .empty() }
            return .just(.setCertificationState(self.currentState.ceritifcationState))
            
        case let .didTapCreateUserButton(name, nickName, gender, birthDay, phoneNumber):
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            
            return .concat(
                startLoading,
                signUpRepository.createUserInformation(name: name, nickname: nickName, gender: gender, birthDay: birthDay, phoneNumber: phoneNumber),
                endLoading
            )
            
        case let .updateToPhoneNumber(phoneNumber):
            return .just(.setUserPhoneNumber(phoneNumber))
            
            
        case .didChangePhoneNumber:
            
            return .just(.setCertificationState(!self.currentState.ceritifcationState))
        }
    }
    
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        
        let fromAppleFullNameMutation = SignUpViewStream.event.flatMap { [weak self] event in
            self?.requestAppleUserProfile(from: event) ?? .empty()
        }
        
        return Observable.of(mutation, fromAppleFullNameMutation).merge()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .setUserName(userName):
            newState.userName = userName
            print("newState userName: \(newState.userName)")
            
        case let .setUserNickName(userNickName):
            newState.userNickName = userNickName
            print("newState userNickName: \(newState.userNickName)")
            
        case let .setUserBirthDay(userBirthDay):
            newState.userBirthDay = userBirthDay
            print("newState userBirtyday : \(newState.userBirthDay)")
            
        case let .setKakaoUserEntity(kakaoEntity):
            newState.kakaoUserEntity = kakaoEntity
            debugPrint("newState Kakao Profile Entity: \(newState.kakaoUserEntity)")
            
        case let .setNaverUserEntity(naverEntity):
            newState.naverUserEntity = naverEntity
            debugPrint("newState Naver Profile Entity: \(newState.naverUserEntity)")
            
        case let .setCertificationState(certificationState):
            newState.ceritifcationState = certificationState
            debugPrint("newState  CertificationState: \(certificationState)")
            
        case let .setAppleUserFullName(fullName):
            newState.applefullName = fullName
            
        case let .setUserGender(gender):
            newState.userGender = gender
            print("set newstate gedner: \(newState.userGender)")
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
            print("Apple Event: \(fullName)")
            return .just(.setAppleUserFullName(fullName))
        default:
            return .empty()
        }
    }
    
}
