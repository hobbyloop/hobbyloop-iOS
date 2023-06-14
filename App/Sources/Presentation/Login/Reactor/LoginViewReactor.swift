//
//  LoginViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/08.
//

import Foundation

import HPExtensions
import HPCommon
import ReactorKit
import RxSwift
import GoogleSignIn

public final class LoginViewReactor: Reactor {
    
    //MARK: Property
    public var initialState: State
    private var loginRepository: LoginViewRepo
    
    //MARK: Action
    public enum Action {
        case viewDidLoad
        case didTapKakaoLogin(AccountType)
        case didTapNaverLogin(AccountType)
        case didTapGoogleLogin(AnyObject, AccountType)
        case didTapAppleLogin(AccountType)
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setAccessToken(String)
        case setAccountType(AccountType)
        case setNaverLogin(Void)
        case setGoogleLogin(Void)
    }
    
    //MARK: State
    public struct State {
        var isLoading: Bool
        @Pulse var authToken: String
        @Pulse var accountType: AccountType
        @Pulse var isShowNaverLogin: Void?
        @Pulse var isShowGoogleLogin: Void?
    }
    
    
    //MARK: InitialState
    init(loginRepository: LoginViewRepo) {
        
        self.loginRepository = loginRepository
        self.initialState = State(
            isLoading: false,
            authToken: "",
            accountType: .none,
            isShowNaverLogin: nil,
            isShowGoogleLogin: nil
        )
    }
    
    
    //MARK: SideEffect
    public func mutate(action: Action) -> Observable<Mutation> {
        
        let startLoading = Observable<Mutation>.just(.setLoading(true))
        let endLoading = Observable<Mutation>.just(.setLoading(false))
        
        switch action {
        case .viewDidLoad:
            
            return .concat(
                startLoading,
                endLoading
            )
        case let .didTapKakaoLogin(type):
            let kakaoTypeMutation = Observable<Mutation>.just(.setAccountType(type))
            
            
            return .concat(
                startLoading,
                kakaoTypeMutation,
                loginRepository.resultKakaoLogin(),
                endLoading
            )
            
        case let .didTapNaverLogin(type):
            let naverTypeMutation = Observable<Mutation>.just(.setAccountType(type))
            
            return .concat(
                startLoading,
                naverTypeMutation,
                loginRepository.responseNaverLogin(),
                endLoading
            )
            
        case let .didTapGoogleLogin(viewController, type):
            let googleTypeMutation = Observable<Mutation>.just(.setAccountType(type))
            
            
            return .concat(
                startLoading,
                googleTypeMutation,
                loginRepository.responseGoogleLogin(to: viewController),
                endLoading
            )
            
        case let .didTapAppleLogin(type):
            let appleTypeMutation = Observable<Mutation>.just(.setAccountType(type))
            
            return .concat(
                startLoading,
                appleTypeMutation,
                loginRepository.responseAppleLogin(),
                endLoading
            
            )
        }
        
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .setAccountType(accountType):
            newState.accountType = accountType
            debugPrint("set Account Type : \(newState.accountType)")
            
        case let .setAccessToken(accessToken):
            newState.authToken = accessToken
            debugPrint("set Kakao Token accessToken: \(newState.authToken)")
            
        case let .setNaverLogin(isShow):
            newState.isShowNaverLogin = isShow

        case let .setGoogleLogin(isShow):
            newState.isShowGoogleLogin = isShow
        }
        
        return newState
    }
    
    
}
