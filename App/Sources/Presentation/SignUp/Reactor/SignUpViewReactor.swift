//
//  SignUpViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import Foundation


import ReactorKit
import RxSwift

final class SignUpViewReactor: Reactor {
    
    //MARK: Property
    
    var initialState: State
    
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        case setLoading(Bool)
    }
    
    struct State {
        @Pulse var isLoading: Bool
    }
    
    init() {
        self.initialState = State(
            isLoading: false
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
    
        
        switch action {
        case .viewDidLoad:
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            
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
