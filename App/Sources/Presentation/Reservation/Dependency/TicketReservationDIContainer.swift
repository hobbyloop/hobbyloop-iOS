//
//  TicketReservationDIContainer.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/09.
//

import Foundation

import HPCommon


public final class TicketReservationDIContainer: DIContainer {

    
    public typealias ViewController = TicketReservationViewController
    
    public typealias Repository = TicketReservationViewRepo
    
    public typealias Reactor = TicketReservationViewReactor
    
    
    public func makeViewController() -> ViewController {
        return TicketReservationViewController(reactor: makeReactor())
    }
    
    public func makeRepository() -> Repository {
        return TicketReservationViewRepository()
    }
    
    public func makeReactor() -> Reactor {
        return TicketReservationViewReactor()
    }
    
    
    
    
}
