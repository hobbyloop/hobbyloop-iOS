//
//  TicketViewReactor.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/04.
//

import Foundation

import HPExtensions
import ReactorKit
import RxSwift

public enum FacilitySortStandard {
    case Location
    case Rank
}

public enum CollectionSortStandard {
    case Recent
    case Rank
}

final class TicketViewReactor: Reactor {
    public var initialState: State
    private var ticketRepository: TicketViewRepo
    
    //MARK: Action
    public enum Action {
        case didTapExercise(IndexPath)
        case didTapRankButton
        case didTapLocationButton
        case didTapSort
        case didTapTicketCollection
        case didTapFacilityArchive(IndexPath)
    }
    
    public enum Mutation {
        case setExercise(Void)
        case setFacilityRankOrLocation(FacilitySortStandard)
        case setTicketCollectionSortStandard(CollectionSortStandard)
        case setFacilityArchive(IndexPath)
        case none
    }
    
    //MARK: State
    public struct State {
        
    }
    
    init(ticketRepository: TicketViewRepo) {
        self.ticketRepository = ticketRepository
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .didTapExercise(_):
            return .just(
                .none
            )
        case .didTapRankButton:
            return .just(
                .none
            )
        case .didTapLocationButton:
            return .just(
                .none
            )
        case .didTapSort:
            return .just(
                .none
            )
        case .didTapTicketCollection:
            return .just(
                .none
            )
        case .didTapFacilityArchive(_):
            return .just(
                .none
            )
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setExercise(let void):
            break
        case .setFacilityRankOrLocation(let facilitySortStandard):
            break
        case .setTicketCollectionSortStandard(let collectionSortStandard):
            break
        case .setFacilityArchive(let indexPath):
            break
        case .none:
            break
        }
        
        return newState
    }
    
}
