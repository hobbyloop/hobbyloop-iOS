//
//  TicketSelectViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/14.
//

import Foundation

import ReactorKit
import HPCommonUI
import HPDomain

public final class TicketSelectViewReactor: Reactor {
    public var initialState: State
    
    private let ticketSelectRepository: TicketSelectViewRepo
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setTicketInfoItem(TicketInfo)
    }
    
    public struct State {
        var isLoading: Bool
        @Pulse var section: [TicketSelectSection]
    }
    
    
    init(ticketSelectRepository: TicketSelectViewRepo) {
        self.ticketSelectRepository = ticketSelectRepository
        self.initialState = State(
            isLoading: false,
            section: [
                .reservationTicket([
                    .reservationTicketItem(TicketSelectCellReactor(model: TicketInfoViewReactor(lessonName: "6:1 그룹레슨 30회", lessoneDate: "2023.04.20 - 2023.06.20", color: "black")))
                ]),
                .reservationTicket([
                    .reservationTicketItem(TicketSelectCellReactor(model: TicketInfoViewReactor(lessonName: "1:1 개인레슨 20회", lessoneDate: "2023.09.17 - 2023.09.30", color: "beanRed")))
                ])
            ]
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return .concat([
                ticketSelectRepository.responseUserTicketList(),
                .just(.setLoading(false))
            ])
        }
        
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            
            newState.isLoading = isLoading
            
        case let .setTicketInfoItem(items):
            print("userTicket Info Items: \(items)")
        }
        
        
        return newState
    }
    
    
    
}
