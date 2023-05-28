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
        case didTapGenderButton
    }
    
    enum Mutation {
        case setLoading(Bool)
        case didTapBirthDayButton(Bool)
        case didTapGenderButton(Bool)
    }
    
    struct State {
        @Pulse var isLoading: Bool
        @Pulse var isGenderSelected: Bool
        @Pulse var isBirthDaySelected: Bool
    }
    
    init() {
        self.initialState = State(
            isLoading: false,
            isGenderSelected: false,
            isBirthDaySelected: false
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
            
        case .didTapGenderButton:
            let didGenderSelectedButton = Observable<Mutation>.just(.didTapGenderButton(currentState.isGenderSelected))
            
            return didGenderSelectedButton
            
        case .didTapBirthDayButton:
            let didBirthdaySelectedButton = Observable<Mutation>.just(.didTapBirthDayButton(currentState.isBirthDaySelected))
            
            return didBirthdaySelectedButton
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .didTapGenderButton(isGenderSelected):
            newState.isGenderSelected = isGenderSelected
            
        case let .didTapBirthDayButton(isBirthDaySelected):
            newState.isBirthDaySelected = !isBirthDaySelected
        }
        
        return newState
    }
}
