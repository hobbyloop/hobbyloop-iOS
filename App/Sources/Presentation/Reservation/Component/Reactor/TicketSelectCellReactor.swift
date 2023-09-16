//
//  TicketSelectCellReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/16.
//

import Foundation

import ReactorKit


public final class TicketSelectCellReactor: Reactor {
    
    public var initialState: State
    
    
    public typealias Action = NoAction
    
    public struct State {
        @Pulse var section: [TicketReservationSection]
    }
    
    
    public init(section: [TicketReservationSection]) {
        self.initialState = State(section: section)
        print("ticket Select Cell Reactor Section: \(section)")

    }
    
    
}
