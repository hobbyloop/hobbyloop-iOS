//
//  LoginViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/08.
//

import Foundation

import HPExtensions
import HPCommon
import HPDomain
import HPNetwork
import ReactorKit


public enum LoginViewStream: HPStreamType {
    public enum Event {
        case responseAccessToken(token: Token)
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
        case setAccessToken(Token?)
        case setAccountType(AccountType)
        case setNaverLogin(Void)
    }
    
    //MARK: State
    public struct State {
        var isLoading: Bool
        @Pulse var authToken: Token?
        var accountType: AccountType
        var isShowNaverLogin: Void?
    }
    
    init(loginRepository: LoginViewRepo) {
        
        self.loginRepository = loginRepository
        self.initialState = State(
            isLoading: false,
            authToken: nil,
            accountType: .none,
            isShowNaverLogin: nil
        )
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let naverTokenUpdates = LoginViewStream.event.flatMap { [weak self] event in
            self?.requestNaverAccessToken(from: event) ?? .empty()
        }
        
        return Observable.merge(mutation, naverTokenUpdates)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case let .didTapKakaoLogin(type):

            return .concat([
                .just(.setLoading(true)),
                .just(.setAccountType(type)),
                loginRepository.resultKakaoLogin(),
                .just(.setLoading(false))
            ])
            
        case let .didTapNaverLogin(type):
            
            return .concat([
                .just(.setLoading(true)),
                .just(.setAccountType(type)),
                loginRepository.responseNaverLogin()
            ])
            
        case let .didTapGoogleLogin(viewController, type):
            
            return .concat([
                .just(.setLoading(true)),
                .just(.setAccountType(type)),
                loginRepository.responseGoogleLogin(to: viewController),
                .just(.setLoading(false))
            ])
            
        case let .didTapAppleLogin(type):
            
            return .concat([
                .just(.setLoading(true)),
                .just(.setAccountType(type)),
                loginRepository.responseAppleLogin(),
                .just(.setLoading(false))
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
        case let .setAccessToken(data):
            guard let originalData = data else { return newState }
            newState.authToken = data
            LoginManager.shared.updateTokens(accessToken: originalData.userToken.accessToken, refreshToken: originalData.userToken.refreshToken)
            UserDefaults.standard.set(Date(), forKey: .expiredAt)
        case let .setNaverLogin(isShow):
            newState.isShowNaverLogin = isShow
        }
        
        return newState
    }
    
    
}


extension LoginViewReactor {
    
    private func requestNaverAccessToken(from event: LoginViewStream.Event) -> Observable<Mutation> {
        switch event {
        case let .responseAccessToken(token):
            return .concat([
                .just(.setAccessToken(token)),
                .just(.setLoading(false))
            ])
        }
    }
    
    
}
