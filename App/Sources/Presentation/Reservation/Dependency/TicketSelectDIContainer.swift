//
//  TicketSelectDIContainer.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/14.
//

import Foundation

import HPCommon


final class TicketSelectDIContainer: DIContainer {

    typealias ViewController = TicketSelectViewController
    
    typealias Repository = TicketSelectViewRepo
    
    typealias Reactor = TicketSelectViewReactor
    
    func makeViewController() -> TicketSelectViewController {
        return TicketSelectViewController(reactor: makeReactor())
    }
    
    func makeReactor() -> TicketSelectViewReactor {
        return TicketSelectViewReactor()
    }
    
    func makeRepository() -> Repository {
        return TicketSelectViewRepository()
    }
    
    
}
