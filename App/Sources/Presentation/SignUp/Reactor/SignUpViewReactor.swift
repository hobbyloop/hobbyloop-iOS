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
    
    func getGenderType() -> String {
        switch self {
        case .male:
            return "남자"
        case .female:
            return "여자"
        }
    }
}



public final class SignUpViewReactor: Reactor {
    
    // MARK: Property
    public var initialState: State
    private var signUpRepository: SignUpViewRepo
    public var accountType: AccountType
    
    public struct State {
        var isLoading: Bool
        @Pulse var kakaoUserEntity: User?
        @Pulse var naverUserEntity: NaverAccount?
        var userAccountEntity: UserAccount?
        var userName: String
        var userNickName: String
        var userGender: HPGender
        var userBirthDay: String
        var phoneNumber: String
        var showsAuthCodeView: Bool
        var authCode: String
        var isVaildPhoneNumber: Bool
        var agreement1IsSelected: Bool
        var agreement2IsSelected: Bool
        var showsDatePickerView: Bool
        var verificationID: String
    }
    
    public enum Action {
        case viewDidLoad
        case updateName(String)
        case updateNickName(String)
        case updateGender(HPGender)
        case updateBirthDay(String)
        case updatePhoneNumber(String)
        case updateAuthCode(String)
        case didTapIssueAuthCodeButton
        case didTapVeirfyAuthCodeButton
        case didTapAllTermsCheckbox
        case didTapReceiveInfoCheckbox
        case didTapCollectInfoCheckbox
        case didTapCreateUserButton
        case didTapDatePickerButton
        case didTapBackgroundView
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setKakaoUserEntity(User)
        case setUserGender(HPGender)
        case setNaverUserEntity(NaverAccount)
        case setUserName(String)
        case setUserNickName(String)
        case setUserBirthDay(String)
        case setUserPhoneNumber(String)
        case setShowAuthCodeView(Bool)
        case setVerificationID(String)
        case setAuthCode(String)
        case setAgreeTerms(Bool, Bool)
        case setCreateUserInfo(UserAccount)
        case showDatePickerView
        case hideDatePickerView
    }
    
    public init(signUpRepository: SignUpViewRepo, accountType: AccountType) {
        self.signUpRepository = signUpRepository
        self.accountType = accountType
        self.initialState = State(
            isLoading: false,
            kakaoUserEntity: nil,
            naverUserEntity: nil,
            userAccountEntity: nil,
            userName: "",
            userNickName: "",
            userGender: .male,
            userBirthDay: "",
            phoneNumber: "",
            showsAuthCodeView: false,
            authCode: "",
            isVaildPhoneNumber: false,
            agreement1IsSelected: false,
            agreement2IsSelected: false,
            showsDatePickerView: false,
            verificationID: ""
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
            
        case let .updateName(userName):
            return .just(.setUserName(userName))
            
        case let .updateNickName(userNickName):
            return .just(.setUserNickName(userNickName))
            
        case let .updateBirthDay(userBirthDay):
            return .just(.setUserBirthDay(userBirthDay))
            
        case let .updateGender(gender):
            return .just(.setUserGender(gender))
            
        case .didTapVeirfyAuthCodeButton:
            return .empty()
            
        case .didTapIssueAuthCodeButton:
            return .concat([
                .just(.setLoading(true)),
                signUpRepository.issueVerificationID(phoneNumber: currentState.phoneNumber),
                .just(.setLoading(false))
            ])
            
        case let .updatePhoneNumber(phoneNumber):
            return .just(.setUserPhoneNumber(phoneNumber))
            
        case let .updateAuthCode(authCode):
            return .just(.setAuthCode(authCode))
            
        case .didTapAllTermsCheckbox:
            let isChecked = currentState.agreement1IsSelected && currentState.agreement2IsSelected
            return .just(.setAgreeTerms(!isChecked, !isChecked))
            
        case .didTapReceiveInfoCheckbox:
            return .just(.setAgreeTerms(!currentState.agreement1IsSelected, currentState.agreement2IsSelected))
            
        case .didTapCollectInfoCheckbox:
            return .just(.setAgreeTerms(currentState.agreement1IsSelected, !currentState.agreement2IsSelected))
            
        case .didTapCreateUserButton:
            return .concat(
                .just(.setLoading(true)),
                signUpRepository.createUserInformation(
                    name: currentState.userName,
                    nickname: currentState.userNickName,
                    gender: currentState.userGender.rawValue,
                    birthDay: currentState.userBirthDay,
                    phoneNumber: currentState.phoneNumber
                ),
                .just(.setLoading(false))
            )
        
        case .didTapDatePickerButton:
            return .just(.showDatePickerView)
        case .didTapBackgroundView:
            return .just(.hideDatePickerView)
        }
    }
    
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        
        let appleNickNameUpdate = SignUpViewStream.event.flatMap { [weak self] event in
            self?.requestAppleUserProfile(from: event) ?? .empty()
        }
        
        return Observable.merge(mutation, appleNickNameUpdate)
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
            
        case let .setShowAuthCodeView(certificationState):
            newState.showsAuthCodeView = certificationState
            
        case let .setVerificationID(verificationID):
            newState.verificationID = verificationID
            
        case let .setUserGender(gender):
            newState.userGender = gender
            
        case let .setCreateUserInfo(accountInfo):
            newState.userAccountEntity = accountInfo
            
        case let .setUserPhoneNumber(phoneNumber):
            newState.phoneNumber = phoneNumber
            newState.isVaildPhoneNumber = phoneNumber.isValidPhoneNumber()
            newState.showsAuthCodeView = false
            newState.authCode = ""
        case let .setAuthCode(authCode):
            newState.authCode = authCode
        case let .setAgreeTerms(agreement1Checked, agreement2Checked):
            newState.agreement1IsSelected = agreement1Checked
            newState.agreement2IsSelected = agreement2Checked
        case .showDatePickerView:
            newState.showsDatePickerView = true
        case .hideDatePickerView:
            newState.showsDatePickerView = false
        
        }
        
        return newState
    }
}



extension SignUpViewReactor {
    
    private func requestAppleUserProfile(from event: SignUpViewStream.Event) -> Observable<Mutation> {
        switch event {
        case let .requestAppleLogin(fullName):
            return .just(.setUserName(fullName))
        }
    }
    
}
