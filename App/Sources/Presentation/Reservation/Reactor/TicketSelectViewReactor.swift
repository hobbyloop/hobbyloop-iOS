//
//  TicketSelectViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/14.
//

import Foundation

import ReactorKit

public final class TicketSelectViewReactor: Reactor {
    public var initialState: State
    
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setTicketInfoItem
    }
    
    public struct State {
        var isLoading: Bool
        @Pulse var section: [TicketSelectSection]
    }
    
    
    init() {
        self.initialState = State(
            isLoading: false,
            section: [
                .reservationTicket([
                    .reservationTicketItem,
                ]),
                .reservationTicketClass([
                    .reservationTicketItem
                ])
            ]
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return .concat([
                .just(.setTicketInfoItem),
                .just(.setLoading(false))
            ])
        }
        
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            
            newState.isLoading = isLoading
            
        case .setTicketInfoItem: break
        }
        
        
        return newState
    }
    
    
    
}
