//
//  TicketSelectTimeViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/20.
//

import Foundation

import HPDomain
import HPNetwork
import RxSwift
import ReactorKit


public protocol TicketSelectTimeViewRepo: AnyObject {
    
    var disposeBag: DisposeBag { get }
    var networkService: TicketSelectService { get }
    

    func responseInstructorList(id: Int) -> Observable<TicketSelectTimeViewReactor.Mutation>
    
}


public final class TicketSelectTimeViewRepository: TicketSelectTimeViewRepo {

    
    public var disposeBag: DisposeBag = DisposeBag()
    public var networkService: TicketSelectService = TicketSelectClient.shared
    
    public func responseInstructorList(id: Int) -> Observable<TicketSelectTimeViewReactor.Mutation> {
        let createInstructorItems = networkService.requestToInstructorList(id: id)
            .asObservable()
            .flatMap { data -> Observable<TicketSelectTimeViewReactor.Mutation> in
                return .just(.setInstructorItems(data))
            }
        
        return createInstructorItems
    }
    
    
    
    
}
