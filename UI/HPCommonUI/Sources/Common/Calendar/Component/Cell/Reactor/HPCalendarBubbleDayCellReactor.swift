//
//  HPCalendarBubbleDayCellReactor.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/19.
//

import Foundation

import ReactorKit

public final class HPCalendarBubbleDayCellReactor: Reactor {
    
    public var initialState: State
    
    
    public typealias Action = NoAction
    
    public struct State {
        var day: String
        var weekDay: String
        var nowDay: String
        var color: String
        var isCompare: Bool
    }
    
    public init(day: String, weekDay: String, nowDay: String, color: String, isCompare: Bool) {
        self.initialState = State(day: day, weekDay: weekDay, nowDay: nowDay, color: color, isCompare: isCompare)
    }
}
