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
import GoogleSignIn

public enum LoginViewStream: HPStreamType {
    public enum Event {
        case responseNaverAccessToken(_ accessToken: String)
        case responseGoogleAccessToken(_ accessToken: String)
        case requestNaverLogin
    }
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
        case didTapGoogleLogin(AnyObject)
        case didTapAppleLogin
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setKakaoAccessToken(String)
        case setNaverLogin(Void)
        case setGoogleLogin(Void)
        case setGoogleAccessToken(String)
        case setNaverAccessToken(String)
    }
    
    //MARK: State
    public struct State {
        var isLoading: Bool
        @Pulse var kakaoToken: String
        @Pulse var naverToken: String
        @Pulse var googleToken: String
        @Pulse var isShowNaverLogin: Void?
        @Pulse var isShowGoogleLogin: Void?
    }
    
    
    //MARK: InitialState
    init(loginRepository: LoginViewRepo) {
        
        self.loginRepository = loginRepository
        self.initialState = State(
            isLoading: false,
            kakaoToken: "",
            naverToken: "",
            googleToken: "",
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
            
        case let .didTapGoogleLogin(viewController):
            return .concat(
                startLoading,
                loginRepository.responseGoogleLogin(to: viewController),
                endLoading
            )
            
        case .didTapAppleLogin:
            return .concat(
                startLoading,
                loginRepository.responseAppleLogin(),
                endLoading
            
            )
        }
        
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let fromNaverLoginMutation = LoginViewStream.event.flatMap { [weak self] event in
            self?.requestNaverAccessToken(from: event) ?? .empty()
        }
        
        let fromGoogleLoginMutation = LoginViewStream.event.flatMap { [weak self] event in
            self?.requestGoogleAccessToken(from: event) ?? .empty()
        }

        return Observable.of(mutation, fromNaverLoginMutation, fromGoogleLoginMutation).merge()
    }
    
    public func transform(action: Observable<Action>) -> Observable<Action> {
        let fromNaverLoginAction = LoginViewStream.event.flatMap { [weak self] event in
            self?.requestNaverLoginAction(from: event) ?? .empty()
        }
        return Observable.of(action, fromNaverLoginAction).merge()
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
            
            
        case let .setGoogleAccessToken(accessToken):
            newState.googleToken = accessToken
            debugPrint("set Google access Token: \(newState.googleToken)")
            
            
        case let .setNaverLogin(isShow):
            newState.isShowNaverLogin = isShow
            
        case let .setGoogleLogin(isShow):
            newState.isShowGoogleLogin = isShow
        }
        
        return newState
    }
    
    
}


public extension LoginViewReactor {
    
    func requestNaverAccessToken(from event: LoginViewStream.Event) -> Observable<Mutation> {
        switch event {
        case let .responseNaverAccessToken(accessToken):
            return .just(.setNaverAccessToken(accessToken))
        default:
            return .empty()
        }
    }
    
    func requestGoogleAccessToken(from event: LoginViewStream.Event) -> Observable<Mutation> {
        
        switch event {
        case let .responseGoogleAccessToken(accessToken):
            return .just(.setGoogleAccessToken(accessToken))
        default:
            return .empty()
        }
    }
    
    
    func requestNaverLoginAction(from event: LoginViewStream.Event) -> Observable<Action> {
        switch event {
        case .requestNaverLogin:
            return .just(.didTapNaverLogin)
        default:
            return .empty()
        }
    }
}
