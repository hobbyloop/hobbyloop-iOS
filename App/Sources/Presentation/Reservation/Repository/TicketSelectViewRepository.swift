//
//  TicketSelectViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/14.
//

import Foundation

import HPNetwork
import RxSwift


public protocol TicketSelectViewRepo: AnyObject {
    var disposeBag: DisposeBag { get }
    
    var networkService: TicketSelectService { get }
    func responseUserTicketList() -> Observable<TicketSelectViewReactor.Mutation>
}


public final class TicketSelectViewRepository: TicketSelectViewRepo {
    //MARK: Property
    public var disposeBag: DisposeBag = DisposeBag()
    public var networkService: TicketSelectService = TicketSelectClient.shared
    
    
    
    public func responseUserTicketList() -> Observable<TicketSelectViewReactor.Mutation> {
        let createUserTicketItem = networkService.requestToTicketInfoList()
            .asObservable()
            .flatMap { data -> Observable<TicketSelectViewReactor.Mutation> in
                
                return .just(.setTicketInfoItem(data))
            }
        
        return createUserTicketItem
    }
    

    
}
