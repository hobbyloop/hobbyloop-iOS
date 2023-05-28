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
    
    // MARK: Property
    var initialState: State
    
    enum Action {
        case viewDidLoad
        case didTapBirthDayButton
    }
    
    enum Mutation {
        case setLoading(Bool)
        case didTapBirthDayButton(Bool)
    }
    
    struct State {
        @Pulse var isLoading: Bool
        @Pulse var isSelected: Bool
    }
    
    init() {
        self.initialState = State(
            isLoading: false,
            isSelected: false
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
            
        case .didTapBirthDayButton:
            let didSelectedButton = Observable<Mutation>.just(.didTapBirthDayButton(currentState.isSelected))
            
            return didSelectedButton
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .didTapBirthDayButton(isSelected):
            newState.isSelected = !isSelected
        }
        
        return newState
    }
}
