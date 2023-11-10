//
//  TicketViewReactor.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/04.
//

import Foundation

import HPDomain
import HPCommon
import HPExtensions
import ReactorKit
import RxSwift

public final class TicketViewReactor: Reactor {
    public var initialState: State
    private var ticketRepository: TicketViewRepo
    public var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwNjQzMjY1MCwidXNlcm5hbWUiOiJOQVZFUl84WlJWVW01Q3JETlF0OHFSYTVJeVRDLUpwSnJpVDFTMURtdHl3bEN4dFNrIn0.mn_e0IBVifYGsky8tkfgalIXhLs09JXNvmKTTGvF-0IBSK74gnoIXOGusWSv0sSppNfVzROEvsTP6nQPi1Tidg"
    private var page = 0
    
    //MARK: Action
    public enum Action {
        case viewDidLoad
        case didTapExercise(TicketType)
        case didTapSortStandard(FacilitySortType)
        case didTapFacilityArchive(Int)
        case didTapLocation(Double, Double)
        case moreLoadPage
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setFacilityInfo([FacilityInfo])
        case setExercise(TicketType)
        case setTicketCollectionSortStandard(FacilitySortType)
        case setFacilityArchive
        case setLocation(Double, Double)
        case setLoopPassOrTicket(TicketSelectedType)
        case increasePageNum
        case increaseFacilityInfo([FacilityInfo])
        case none
    }
    
    //MARK: State
    public struct State {
        var isLoading: Bool
        @Pulse var section: [FacilityInfo]
        var loopPassSelect: TicketSelectedType
        var sortType: FacilitySortType
        var ticketType: TicketType
        var location: (Double, Double)
        var pageNum: Int
    }
    
    init(ticketRepository: TicketViewRepo) {
        self.ticketRepository = ticketRepository
        self.initialState = State(isLoading: false,
                                  section: [],
                                  loopPassSelect: .ticket,
                                  sortType: .recently,
                                  ticketType: .헬스, 
                                  location: (60, 60), 
                                  pageNum: 0
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        let startLoading = Observable<Mutation>.just(.setLoading(true))
        let endLoading = Observable<Mutation>.just(.setLoading(false))
        
        switch action {
        case .viewDidLoad:
            return .concat(
                ticketRepository.responseFacilityList(token: token,
                                                      facilitySortType: initialState.sortType,
                                                      ticketType: initialState.ticketType,
                                                      mapx: initialState.location.0,
                                                      mapy: initialState.location.1,
                                                      page: page)
                .map { info in
                        .setFacilityInfo(info)
                }
            )
        case .didTapExercise(let type):
            return .concat(
                Observable<Mutation>.just(.setExercise(type)),
                ticketRepository.responseFacilityList(token: token,
                                                      facilitySortType: initialState.sortType,
                                                      ticketType: initialState.ticketType,
                                                      mapx: initialState.location.0,
                                                      mapy: initialState.location.1,
                                                      page: page)
                .map { info in
                        .setFacilityInfo(info)
                }
            )
        case .didTapSortStandard(let type):
            return .concat(
                Observable<Mutation>.just(.setTicketCollectionSortStandard(type)),
                ticketRepository.responseFacilityList(token: token,
                                                      facilitySortType: initialState.sortType,
                                                      ticketType: initialState.ticketType,
                                                      mapx: initialState.location.0,
                                                      mapy: initialState.location.1,
                                                      page: page)
                .map { info in
                        .setFacilityInfo(info)
                }
            )
        case .didTapLocation(let l_x, let l_y):
            return .concat(
                Observable<Mutation>.just(.setLocation(l_x, l_y)),
                ticketRepository.responseFacilityList(token: token,
                                                      facilitySortType: initialState.sortType,
                                                      ticketType: initialState.ticketType,
                                                      mapx: initialState.location.0,
                                                      mapy: initialState.location.1,
                                                      page: page)
                .map { info in
                        .setFacilityInfo(info)
                }
            )
        case .didTapFacilityArchive(let facilityId):
            return .concat(
                ticketRepository.responseFacilityArchive(token: token,
                                                         facilityId: facilityId)
            )
            
        case .moreLoadPage:
            return .concat(
                Observable<Mutation>.just(.increasePageNum),
                ticketRepository.responseFacilityList(token: token,
                                                      facilitySortType: initialState.sortType,
                                                      ticketType: initialState.ticketType,
                                                      mapx: initialState.location.0,
                                                      mapy: initialState.location.1,
                                                      page: page)
                .map { info in
                        .increaseFacilityInfo(info)
                }
            )
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            break
        case let .setFacilityInfo(item):
            newState.section = item
            break
        case let .setTicketCollectionSortStandard(collectionSortStandard):
            newState.sortType = collectionSortStandard
            newState.pageNum = 0
            break
        case .setFacilityArchive:
            break
        case let .setLoopPassOrTicket(loopPassType):
            newState.loopPassSelect = loopPassType
            newState.pageNum = 0
            break
        case let .setExercise(type):
            newState.ticketType = type
            newState.pageNum = 0
            break
        case let .setLocation(x, y):
            newState.location = (x, y)
            newState.pageNum = 0
            break
        case .increasePageNum:
            newState.pageNum += 1
            break
        case let .increaseFacilityInfo(item):
            newState.section += item
            break
        case .none:
            break
        
        }
        
        return newState
    }
    
}
