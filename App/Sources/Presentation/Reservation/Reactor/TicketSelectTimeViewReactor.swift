//
//  TicketSelectTimeViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/20.
//

import Foundation

import HPDomain
import ReactorKit


public final class TicketSelectTimeViewReactor: Reactor {
    
    public var initialState: State
    private let ticketSelectTimeRepository: TicketSelectTimeViewRepo
    
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setInstructorItems(Instructor)
        case setProfileSectionItem
    }
    
    public struct State {
        var isLoading: Bool
        @Pulse var profileSection: [TicketInstructorProfileSection]
    }
    
    init(ticketSelectTimeRepository: TicketSelectTimeViewRepo) {
        self.ticketSelectTimeRepository = ticketSelectTimeRepository
        self.initialState = State(
            isLoading: false,
            profileSection: [
                .instructorProfile([
                    .instructorProfileItem(TicketInstructorProfileCellReactor(
                        imageURL: "profile",
                        numberOfPages: 3,
                        currentPage: 0
                    )),
                    .instructorProfileItem(TicketInstructorProfileCellReactor(
                        imageURL: "profile",
                        numberOfPages: 3,
                        currentPage: 1)),
                    .instructorProfileItem(TicketInstructorProfileCellReactor(
                        imageURL: "profile",
                        numberOfPages: 3,
                        currentPage: 2))
                ])
            
            ]
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return .concat([
                .just(.setProfileSectionItem),
                ticketSelectTimeRepository.responseInstructorList(id: 2)
            
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case .setProfileSectionItem: break
        case let .setInstructorItems(items):
            print("Instructor items: \(items)")
        }
        return newState
    }
    
}
