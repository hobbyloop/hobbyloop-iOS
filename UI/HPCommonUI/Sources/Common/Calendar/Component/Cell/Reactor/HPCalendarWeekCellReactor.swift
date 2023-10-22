//
//  HPCalendarWeekCellReactor.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/19.
//

import Foundation

import ReactorKit


public final class HPCalendarWeekCellReactor: Reactor {
    public var initialState: State
    
    public typealias Action = NoAction

    
    public struct State {
        var week: String
    }
    
    public init(week: String) {
        self.initialState = State(week: week)
    }
    
}
