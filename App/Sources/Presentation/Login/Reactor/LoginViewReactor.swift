//
//  LoginViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/08.
//

import Foundation

import ReactorKit
import RxSwift


public final class LoginViewReactor: Reactor {
    
    //MARK: Property
    public var initialState: State
    private var loginRepository: LoginViewRepo
    
    //MARK: Action
    public enum Action {
        case viewDidLoad
        case didTapKakaoLogin
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setKakaoAccessToken(String)
    }
    
    //MARK: State
    public struct State {
        @Pulse var isLoading: Bool
        @Pulse var kakaoToken: String
    }
    
    
    //MARK: InitialState
    init(loginRepository: LoginViewRepo) {
        
        self.loginRepository = loginRepository
        self.initialState = State(
            isLoading: false,
            kakaoToken: ""
        )
    }
    
    
    //MARK: SideEffect
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            
            return .concat(
                startLoading,
                endLoading
            )
        case .didTapKakaoLogin:
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            
            return .concat(
                startLoading,
                loginRepository.responseKakaoLogin(),
                endLoading
            )
        }
        
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .setKakaoAccessToken(accessToken):
            newState.kakaoToken = accessToken
        }
        
        return newState
    }
    
    
}
