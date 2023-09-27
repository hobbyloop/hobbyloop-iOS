//
//  TicketCalendarCellReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/27.
//

import Foundation

import ReactorKit
import RxCocoa
import HPCommonUI


public final class TicketCalendarCellReactor: Reactor {
    
    
    public var initialState: State
    
    
    public enum Action {
        case didTapCalendarStyleButton
    }
    
    public enum Mutation {
        case setCalendarStyle(CalendarStyle)
    }
    
    
    public struct State {
        var isStyle: CalendarStyle
    }
    
    
    init() {
        self.initialState = State(isStyle: .bubble)
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapCalendarStyleButton:
            return .just(
                .setCalendarStyle(self.currentState.isStyle == .bubble ? .default : .bubble)
            )
        }
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case let .setCalendarStyle(isStyle):
            newState.isStyle = isStyle
        }
        
        return newState
    }
    
}
