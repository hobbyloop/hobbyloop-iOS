//
//  SignUpTermsViewReactor.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/06/19.
//

import Foundation

import HPThirdParty
import RxSwift
import ReactorKit



public final class SignUpTermsViewReactor: Reactor {
    
    // MARK: Property
    public var initialState: State
    
    
    // MARK: Action
    public enum Action {
        case didTapSelectBox(SignUpTermsType)
    }
    
    public enum Mutation {
        case setSelectType(SignUpTermsType)
    }
    
    // MARK: State
    public struct State {
        var termsType: SignUpTermsType
    }
    
    
    public init() {
        self.initialState = State(termsType: .none)
    }
    
    
    
    // MARK: SideEffect
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didTapSelectBox(type):
            return .just(.setSelectType(type))

        }
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setSelectType(termsType):
            newState.termsType = termsType
        }
        
        return newState
    }
    
    
    
    
}
