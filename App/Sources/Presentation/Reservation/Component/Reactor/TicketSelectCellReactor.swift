//
//  TicketSelectCellReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/16.
//

import Foundation

import ReactorKit
import HPCommonUI


public final class TicketSelectCellReactor: Reactor {
    
    public var initialState: State
    
    
    public typealias Action = NoAction
    
    public struct State {
        @Pulse var model: TicketInfoViewReactor
    }
    
    
    public init(model: TicketInfoViewReactor) {
        self.initialState = State(model: model)
        print("ticket Select Cell Reactor Section: \(model)")

    }
    
    
}
