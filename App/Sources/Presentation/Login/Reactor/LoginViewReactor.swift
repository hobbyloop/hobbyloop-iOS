//
//  LoginViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/08.
//

import Foundation

import HPExtensions
import ReactorKit
import RxSwift

public enum LoginViewStream: HPStreamType {
    public enum Event {
        case responseNaverAccessToken(_ accessToken: String)
    }
    case none
}


public final class LoginViewReactor: Reactor {
    
    //MARK: Property
    public var initialState: State
    private var loginRepository: LoginViewRepo
    
    //MARK: Action
    public enum Action {
        case viewDidLoad
        case didTapKakaoLogin
        case didTapNaverLogin
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setKakaoAccessToken(String)
        case setNaverLogin(Void)
        case setNaverAccessToken(String)
    }
    
    //MARK: State
    public struct State {
        @Pulse var isLoading: Bool
        @Pulse var kakaoToken: String
        @Pulse var naverToken: String
        @Pulse var isShowNaverLogin: Void?
    }
    
    
    //MARK: InitialState
    init(loginRepository: LoginViewRepo) {
        
        self.loginRepository = loginRepository
        self.initialState = State(
            isLoading: false,
            kakaoToken: "",
            naverToken: "",
            isShowNaverLogin: nil
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
        case .didTapKakaoLogin:
            
            return .concat(
                startLoading,
                loginRepository.resultKakaoLogin(),
                endLoading
            )
            
        case .didTapNaverLogin:
            return .concat(
                startLoading,
                loginRepository.responseNaverLogin(),
                endLoading
            )
        }
        
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let fromNaverLoginMutation = LoginViewStream.event.flatMap { [weak self] event in
            self?.requestNaverAccessToken(from: event) ?? .empty()
        }

        return Observable.of(mutation, fromNaverLoginMutation).merge()
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .setKakaoAccessToken(accessToken):
            newState.kakaoToken = accessToken
            debugPrint("set Kakao Token accessToken: \(newState.kakaoToken)")
            
        case let .setNaverAccessToken(accessToken):
            newState.naverToken = accessToken
            debugPrint("set Naver access Token: \(newState.naverToken)")
            
        case let .setNaverLogin(isShow):
            newState.isShowNaverLogin = isShow
        }
        
        return newState
    }
    
    
}


public extension LoginViewReactor {
    
    func requestNaverAccessToken(from event: LoginViewStream.Event) -> Observable<Mutation> {
        switch event {
        case let .responseNaverAccessToken(accessToken):
            return .just(.setNaverAccessToken(accessToken))
        }
    }
    
}
