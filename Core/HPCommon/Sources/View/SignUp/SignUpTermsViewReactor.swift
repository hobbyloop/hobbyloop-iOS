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
        case didTapAllSelectBox(SignUpTermsType)
        case didTapReceiveSelectBox(SignUpTermsType)
        case didTapInfoSelectBox(SignUpTermsType)
    }
    
    public enum Mutation {
        case setAllSelectType(SignUpTermsType)
        case setReceiveSelectBox(SignUpTermsType)
        case setInfoSelectBox(SignUpTermsType)
    }
    
    // MARK: State
    public struct State {
        var allTermsType: SignUpTermsType
        var receiveTermsType: SignUpTermsType
        var infoTermsType: SignUpTermsType
    }
    
    
    public init() {
        self.initialState = State(
            allTermsType: .none,
            receiveTermsType: .none,
            infoTermsType: .none
        )
    }
    
    
    
    // MARK: SideEffect
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didTapAllSelectBox(alltype):
            return .just(.setAllSelectType(alltype))
        case let .didTapReceiveSelectBox(recevieType):
            return .just(.setReceiveSelectBox(recevieType))
            
        case let .didTapInfoSelectBox(infoType):
            return .just(.setInfoSelectBox(infoType))
        }
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setAllSelectType(allTermsType):
            guard vaildationSingupTerms() else {
                newState.allTermsType = .none
                newState.infoTermsType = .none
                newState.receiveTermsType = .none
                return newState
            }
            
            newState.allTermsType = allTermsType
            newState.infoTermsType = .info
            newState.receiveTermsType = .receive
            
            
        case let .setReceiveSelectBox(receiveTermsType):
            guard currentState.receiveTermsType == .receive else {
                newState.receiveTermsType = receiveTermsType
                return newState
            }
            
            newState.receiveTermsType = .none
            
        case let .setInfoSelectBox(infoTermsType):
            guard currentState.infoTermsType == .info else {
                newState.infoTermsType = infoTermsType
                return newState
            }
            newState.infoTermsType = .none
        }
        
        return newState
    }
    
    
    
    
}


private extension SignUpTermsViewReactor {
    
    func vaildationSingupTerms() -> Bool {
        
        if self.currentState.allTermsType == .all && self.currentState.infoTermsType == .info && self.currentState.receiveTermsType == .receive {
            return false
        } else {
            return true
        }

        
    }
    
}
