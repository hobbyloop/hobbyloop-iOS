//
//  HPCalendarViewReactor.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/20.
//

import Foundation

import ReactorKit
import RxSwift


public final class HPCalendarViewReactor: Reactor {
    
    //MARK: Property
    public var initialState: State
    
    //MARK: Action
    public enum Action {
        case loadView
    }
    
    //MARK: Mutation
    public enum Mutation {
        case setCalendarItems
    }
    
    //MARK: State
    public struct State {
        var days: [String]
        @Pulse var section: [CalendarSection]
    }
    
    
    public init() {
        self.initialState = State(
            days: [],
            section: [.calendar([.calnedarItem])]
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        
        switch mutation {
            
        case .setCalendarItems:
            
            return newState
        }
    }
    
}

