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
        case requestGoogleLogin(_ profile: GIDGoogleUser)
        case requestAppleLogin(_ profie: String)
    }
}


public enum HPGender: String, Equatable {
    case male
    case female
    case none
}



public final class SignUpViewReactor: Reactor {
    
    // MARK: Property
    public var initialState: State
    private var signUpRepository: SignUpViewRepo
    public var accountType: AccountType
    
    public enum Action {
        case viewDidLoad
        case didTapBirthDayButton
        case didTapGenderButton(HPGender)
        case didTapAuthCodeButton
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case didTapBirthDayButton(Bool)
        case setKakaoUserEntity(User)
        case setUserGender(HPGender)
        case setNaverUserEntity(NaverAccount)
        case setGoogleUserEntity(GIDGoogleUser)
        case setAppleUserFullName(String)
    }
    
    public struct State {
        var isLoading: Bool
        @Pulse var isBirthDaySelected: Bool
        @Pulse var kakaoUserEntity: User?
        @Pulse var naverUserEntity: NaverAccount?
        @Pulse var googleUserEntity: GIDGoogleUser?
        var userGender: HPGender
        var applefullName: String
    }
    
    public init(signUpRepository: SignUpViewRepo, accountType: AccountType) {
        self.signUpRepository = signUpRepository
        self.accountType = accountType
        self.initialState = State(
            isLoading: false,
            isBirthDaySelected: false,
            kakaoUserEntity: nil,
            naverUserEntity: nil,
            googleUserEntity: nil,
            userGender: .none,
            applefullName: ""
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
    
        
        switch action {
        case .viewDidLoad:
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            var requestProfile = Observable<Mutation>.empty()
            
            if accountType == .kakao {
                requestProfile = signUpRepository.responseKakaoProfile()
            } else if accountType == .naver {
                requestProfile = signUpRepository.responseNaverProfile()
            }
            //TODO: Google, Apple Mutaion 추가
            
            return .concat(
                startLoading,
                requestProfile,
                endLoading
            )
        case let .didTapGenderButton(gender):
            let setUserInfoGender = Observable<Mutation>.just(.setUserGender(gender))
            
            return setUserInfoGender
            
        case .didTapBirthDayButton:
            let didBirthdaySelectedButton = Observable<Mutation>.just(.didTapBirthDayButton(currentState.isBirthDaySelected))
            
            return didBirthdaySelectedButton
            
        case .didTapAuthCodeButton:
            
            return .empty()
        }
    }
    
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let fromGoogleProfileMutation = SignUpViewStream.event.flatMap { [weak self] event in
            self?.requestGoogleUserProfile(from: event) ?? .empty()
        }
        
        let fromAppleFullNameMutation = SignUpViewStream.event.flatMap { [weak self] event in
            self?.requestAppleUserProfile(from: event) ?? .empty()
        }
        
        print("test Google Profile: \(fromGoogleProfileMutation)")
        
        return Observable.of(mutation, fromGoogleProfileMutation, fromAppleFullNameMutation).merge()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .didTapBirthDayButton(isBirthDaySelected):
            newState.isBirthDaySelected = !isBirthDaySelected
            
        case let .setKakaoUserEntity(kakaoEntity):
            newState.kakaoUserEntity = kakaoEntity
            debugPrint("newState Kakao Profile Entity: \(newState.kakaoUserEntity)")
            
        case let .setNaverUserEntity(naverEntity):
            newState.naverUserEntity = naverEntity
            debugPrint("newState Naver Profile Entity: \(newState.naverUserEntity)")
            
        case let .setGoogleUserEntity(googleEntity):
            newState.googleUserEntity = googleEntity
            
        case let .setAppleUserFullName(fullName):
            newState.applefullName = fullName
            
        case let .setUserGender(gender):
            newState.userGender = gender
        }
        
        return newState
    }
}



public extension SignUpViewReactor {
    
    func requestGoogleUserProfile(from event: SignUpViewStream.Event) -> Observable<Mutation> {
        switch event {
        case let .requestGoogleLogin(profile):
            print("Google Event: \(profile)")
            return .just(.setGoogleUserEntity(profile))
        default:
            return .empty()
        }
    }
    
    
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
