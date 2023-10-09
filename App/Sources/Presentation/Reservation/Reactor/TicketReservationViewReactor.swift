//
//  TicketReservationViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/09.
//

import Foundation


import ReactorKit


public final class TicketReservationViewReactor: Reactor {
    
    public var initialState: State
    
    
    public enum Action {
        case viewDidLoad
    }
    
    
    public enum Mutation {
        case setLoading(Bool)
    }
    
    public struct State {
        var isLoading: Bool
        @Pulse var reservationSection: [TicketReservationSection]
    }
    
    public init() {
        self.initialState = State(
            isLoading: false,
            reservationSection: [
                .reservationTicket([.reservationTicketItem]),
                .reservationNotice([.reservationNoticeItem])
            
            ]
        )
    }
    
    
    
    
}
