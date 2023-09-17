//
//  TicketInfoViewReactor.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/17.
//

import Foundation

import ReactorKit


public final class TicketInfoViewReactor: Reactor {
    
    public var initialState: State
    
    public typealias Action = NoAction
    
    public enum Mutation {
        case setTicketInfo
    }
    
    public struct State {
        var lessonName: String
        var lessonDate: String
    }
    
    public init() {
        self.initialState = State(
            lessonName: "",
            lessonDate: ""
        )
    }


}
