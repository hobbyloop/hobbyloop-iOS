//
//  HPCalendarDayCellReactor.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/19.
//

import Foundation

import ReactorKit


public final class HPCalendarDayCellReactor: Reactor {
    public var initialState: State
    
    
    // TODO: 사용자가 Cell 클릭시 사용자가 가지고 있는 이용권 리스트 조회 API 호출
    public typealias Action = NoAction
    
    public struct State {
        var days: String
        var isCompare: Bool
    }
    
    public init(days: String, isCompare: Bool) {
        self.initialState = State(days: days, isCompare: isCompare)
    }
    
    
}
