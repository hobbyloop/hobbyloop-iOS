//
//  LoginViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/08.
//

import Foundation

import ReactorKit
import RxSwift


final class LoginViewReactor: Reactor {
    
    //MARK: Property
    var initialState: State
   
    //MARK: Action
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        case setLoading(Bool)
    }
    
    //MARK: State
    struct State {
        @Pulse var isLoading: Bool
    }
    
    
    //MARK: InitialState
    init() {
        self.initialState = State(
            isLoading: false
        )
    }
    
    
    //MARK: SideEffect
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            let startLoading = Observable<Mutation>.just(.setLoading(false))
            let endLoading = Observable<Mutation>.just(.setLoading(true))
            
            return .concat(
                startLoading,
                endLoading
            )
        }
        
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        }
        
        return newState
    }
    
    
}
