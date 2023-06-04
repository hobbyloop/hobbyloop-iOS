//
//  SignUpViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import Foundation

import HPDomain
import HPCommon
import ReactorKit
import RxSwift
import KakaoSDKUser

public final class SignUpViewReactor: Reactor {
    
    // MARK: Property
    public var initialState: State
    private var signUpRepository: SignUpViewRepo
    private var accountType: AccountType
    
    public enum Action {
        case viewDidLoad
        case didTapBirthDayButton
        case didTapGenderButton
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case didTapBirthDayButton(Bool)
        case didTapGenderButton(Bool)
        case setKakaoUserEntity(User)
        case setNaverUserEntity(NaverAccount)
    }
    
    public struct State {
        @Pulse var isLoading: Bool
        @Pulse var isGenderSelected: Bool
        @Pulse var isBirthDaySelected: Bool
        @Pulse var kakaoUserEntity: User?
        @Pulse var naverUserEntity: NaverAccount?
    }
    
    public init(signUpRepository: SignUpViewRepo, accountType: AccountType) {
        self.signUpRepository = signUpRepository
        self.accountType = accountType
        self.initialState = State(
            isLoading: false,
            isGenderSelected: false,
            isBirthDaySelected: false,
            kakaoUserEntity: nil,
            naverUserEntity: nil
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
            
        case .didTapGenderButton:
            let didGenderSelectedButton = Observable<Mutation>.just(.didTapGenderButton(currentState.isGenderSelected))
            
            return didGenderSelectedButton
            
        case .didTapBirthDayButton:
            let didBirthdaySelectedButton = Observable<Mutation>.just(.didTapBirthDayButton(currentState.isBirthDaySelected))
            
            return didBirthdaySelectedButton
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .didTapGenderButton(isGenderSelected):
            newState.isGenderSelected = isGenderSelected
            
        case let .didTapBirthDayButton(isBirthDaySelected):
            newState.isBirthDaySelected = !isBirthDaySelected
            
        case let .setKakaoUserEntity(kakaoEntity):
            newState.kakaoUserEntity = kakaoEntity
            debugPrint("newState Kakao Profile Entity: \(newState.kakaoUserEntity)")
            
        case let .setNaverUserEntity(naverEntity):
            newState.naverUserEntity = naverEntity
            debugPrint("newState Naver Profile Entity: \(newState.naverUserEntity)")
        }
        
        return newState
    }
}
