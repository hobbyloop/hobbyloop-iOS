//
//  TicketViewRepository.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/04.
//

import Foundation

import ReactorKit
import HPCommon
import HPExtensions

public protocol TicketViewRepo {
    var disposeBag: DisposeBag { get }
    
}

public final class TicketViewRepository: NSObject, TicketViewRepo {
    public var disposeBag: DisposeBag = DisposeBag()
    
    public override init() {
        super.init()
    }
    
//    public func
}
