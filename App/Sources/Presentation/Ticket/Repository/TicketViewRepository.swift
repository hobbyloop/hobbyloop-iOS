//
//  TicketViewRepository.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/04.
//

import Foundation

import ReactorKit
import HPCommon
import HPDomain
import HPExtensions
import HPNetwork

public protocol TicketViewRepo {
    var disposeBag: DisposeBag { get }
    
    var networkService: APIService { get }
    
    /// 이용권 데이터 Request
    func responseFacilityList(token: String,
                              facilitySortType: FacilitySortType,
                              ticketType: TicketType,
                              mapx: Double,
                              mapy: Double,
                              page: Int) -> Observable<[FacilityInfo]>
    
    /// 업체 저장하기
    func responseFacilityArchive(token: String,
                                 facilityId: Int) -> Observable<TicketViewReactor.Mutation>
}

public final class TicketViewRepository: NSObject, TicketViewRepo {
    public var networkService: HPNetwork.APIService = APIClient.shared
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    public override init() {
        super.init()
    }
    
    /// - note: 시설/이용권 리스트를 받아오기 위한 메서드
    /// - Parameters:
    ///   - token:             `토큰 값` 로그인 시 얻은 토큰 값 전달 by default
    ///   - facilitySortType:  `FacilitySortType Enum`으로 값을 전달 by default
    ///   - ticketType:        `ticketType Enum`으로 값을 전달 by default
    ///   - mapx:              `경도 Double` 좌표 전달 by default
    ///   - mapy:              `위도 Double` 좌표 전달 by default
    ///   - page:              `현재 Page Int`을 전달
    /// - Returns:             `RxSwift.Observable<TicketViewReactor.Mutation>`
    public func responseFacilityList(token: String,
                                     facilitySortType: FacilitySortType,
                                     ticketType: TicketType,
                                     mapx: Double,
                                     mapy: Double,
                                     page: Int) -> Observable<[FacilityInfo]> {
        return networkService.request(BaseEntity<[FacilityInfo]>.self,
                                      TicketRouter.getFacilityList(token: token,
                                                                   facilitySortType: facilitySortType,
                                                                   ticketType: ticketType,
                                                                   mapx: mapx,
                                                                   mapy: mapy,
                                                                   page: page))
        .asObservable()
        .map { facilityInfo in
            guard let info = facilityInfo.data else { return [] }
            return info
        }
        
    }
    
    /// - note: 시설을 북마크하기위한 메서드
    /// - Parameters:
    ///   - facilityId:        `업체 Code` 업체 코드 등록 `Int64` by default
    /// - Returns:             `RxSwift.Observable<TicketViewReactor.Mutation>`
    public func responseFacilityArchive(token: String,
                                        facilityId: Int) -> RxSwift.Observable<TicketViewReactor.Mutation> {
        return networkService.request(BookMark.self, TicketRouter.FacilityArchive(token: token, facilityId: facilityId))
            .asObservable()
            .map { _ in
                return .setFacilityArchive
            }
    }
}
