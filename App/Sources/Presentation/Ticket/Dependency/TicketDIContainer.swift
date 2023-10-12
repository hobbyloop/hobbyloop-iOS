//
//  TicketDIContainer.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/04.
//

import Foundation

import HPCommon


class TicketDIContainer: DIContainer {
    //MARK: Property
    public typealias ViewController = TicketViewController
    public typealias Repository = TicketViewRepo
    public typealias Reactor = TicketViewReactor
    
    func makeViewController() -> TicketViewController {
        return TicketViewController(reactor: makeReactor())
    }
    
    func makeRepository() -> TicketViewRepo {
        return TicketViewRepository()
    }
    
    func makeReactor() -> TicketViewReactor {
        return TicketViewReactor(ticketRepository: makeRepository())
    }
    
    
}
