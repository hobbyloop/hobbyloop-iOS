//
//  TicketSelectTimeDIContainer.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/20.
//

import Foundation

import HPCommon


public final class TicketSelectTimeDIContainer: DIContainer {
        
    public typealias ViewController = TicketSelectTimeViewController
    
    public typealias Reactor = TicketSelectTimeViewReactor
    
    public typealias Repository = TicketSelectTimeViewRepo
    
    
    
    
    public func makeViewController() -> ViewController {
        return TicketSelectTimeViewController(reactor: makeReactor())
    }
    
    public func makeRepository() -> Repository {
        return TicketSelectTimeViewRepository()
    }
    
    public func makeReactor() -> Reactor {
        return TicketSelectTimeViewReactor()
    }
    
}
