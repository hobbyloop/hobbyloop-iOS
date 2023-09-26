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


public enum LoginViewStream: HPStreamType {
    public enum Event {
        case responseAccessToken(token: String)
    }
}


public final class LoginViewReactor: Reactor {
    
    //MARK: Property
    public var initialState: State
    private var loginRepository: LoginViewRepo
    
    //MARK: Action
    public enum Action {
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
        var accountType: AccountType
        var isShowNaverLogin: Void?
        var isShowGoogleLogin: Void?
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
    
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let fromGoogleLoginMutation = LoginViewStream.event.flatMap { [weak self] event in
            self?.requestGoogleAccessToken(from: event) ?? .empty()
        }
        
        return Observable.of(mutation, fromGoogleLoginMutation).merge()
    }
    
    
    //MARK: SideEffect
    public func mutate(action: Action) -> Observable<Mutation> {
        
        let startLoading = Observable<Mutation>.just(.setLoading(true))
        
        switch action {
        case let .didTapKakaoLogin(type):
            let kakaoTypeMutation = Observable<Mutation>.just(.setAccountType(type))
            return .concat([
                startLoading,
                kakaoTypeMutation,
                loginRepository.resultKakaoLogin()
            ])
            
        case let .didTapNaverLogin(type):
            let naverTypeMutation = Observable<Mutation>.just(.setAccountType(type))
            
            return .concat([
                startLoading,
                naverTypeMutation,
                loginRepository.responseNaverLogin()
            ])
            
        case let .didTapGoogleLogin(viewController, type):
            let googleTypeMutation = Observable<Mutation>.just(.setAccountType(type))
            
            
            return .concat([
                startLoading,
                googleTypeMutation,
                loginRepository.responseGoogleLogin(to: viewController)
            ])
            
        case let .didTapAppleLogin(type):
            let appleTypeMutation = Observable<Mutation>.just(.setAccountType(type))
            
            return .concat([
                startLoading,
                appleTypeMutation,
                loginRepository.responseAppleLogin()
            ])
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




private extension LoginViewReactor {
    
    func requestGoogleAccessToken(from event: LoginViewStream.Event) -> Observable<Mutation> {
        switch event {
        case let .responseAccessToken(token):
            return .concat([
                .just(.setAccessToken(token)),
                .just(.setLoading(false))
            ])
        }
    }
    
    
}
