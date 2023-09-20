//
//  TicketSelectTimeViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/20.
//

import Foundation

import ReactorKit


public final class TicketSelectTimeViewReactor: Reactor {
    
    public var initialState: State
    
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setProfileSectionItem
    }
    
    public struct State {
        var isLoading: Bool
        @Pulse var profileSection: [TicketInstructorProfileSection]
    }
    
    init() {
        self.initialState = State(
            isLoading: false,
            profileSection: [
                .instructorProfile([
                    .instructorProfileItem
                ])
            
            ]
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return .just(.setProfileSectionItem)
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case .setProfileSectionItem: break
        }
        return newState
    }
    
}
