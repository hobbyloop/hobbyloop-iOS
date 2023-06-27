//
//  HomeViewRepository.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/03.
//

import Foundation

import ReactorKit
import HPCommon
import HPExtensions

public protocol HomeViewRepo {
    var disposeBag: DisposeBag { get }
    
}

public final class HomeViewRepository: HomeViewRepo {
    public var disposeBag: DisposeBag = DisposeBag()
    
//    public func 
}
