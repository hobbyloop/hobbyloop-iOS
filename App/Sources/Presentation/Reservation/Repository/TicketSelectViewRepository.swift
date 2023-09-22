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
    
    var networkService: APIService { get }
}


public final class TicketSelectViewRepository: TicketSelectViewRepo {
    //MARK: Property
    public var disposeBag: DisposeBag = DisposeBag()
    public var networkService: APIService = APIClient.shared

    
}
