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
import HPNetwork

public protocol HomeViewRepo {
    var disposeBag: DisposeBag { get }
    var networkService: ReservationService { get }
    func fetchLatestReservationInfo() -> Observable<HomeViewReactor.Mutation>
}

public final class HomeViewRepository: HomeViewRepo {
    public var disposeBag: DisposeBag = DisposeBag()
    
    public var networkService: ReservationService = ReservationClient.shared
    
    
    public func fetchLatestReservationInfo() -> Observable<HomeViewReactor.Mutation> {
        let createLatestReservationItem = networkService.requestToReservationList()
            .asObservable()
            .flatMap { data -> Observable<HomeViewReactor.Mutation> in
                return .just(.setLatestReservationItem(data))
            }
        return createLatestReservationItem
    }
    
}
