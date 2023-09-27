//
//  TicketSelectTimeViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/20.
//

import Foundation

import HPDomain
import ReactorKit
import HPCommonUI


public final class TicketSelectTimeViewReactor: Reactor {
    
    public var initialState: State
    private let ticketSelectTimeRepository: TicketSelectTimeViewRepo
    
    
    public enum Action {
        case viewDidLoad
        case didTapCalendarStyleButton
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setInstructorItems(Instructor)
        case setProfileSectionItem
        case setCalendarStyle(CalendarStyle)
    }
    
    public struct State {
        var isLoading: Bool
        var isStyle: CalendarStyle
        @Pulse var scheduleSection: [TicketScheduleSection]
        @Pulse var profileSection: [TicketInstructorProfileSection]
    }
    
    init(ticketSelectTimeRepository: TicketSelectTimeViewRepo) {
        self.ticketSelectTimeRepository = ticketSelectTimeRepository
        self.initialState = State(
            isLoading: false,
            isStyle: .bubble,
            scheduleSection: [
                .instructorSchedule([
                    .instructorScheduleItem,
                    .instructorScheduleItem,
                    .instructorScheduleItem,
                    .instructorScheduleItem
                ])
            ],
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
            
        case .didTapCalendarStyleButton:
            return .just(
                .setCalendarStyle(self.currentState.isStyle == .bubble ? .default : .bubble)
            )
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case .setProfileSectionItem: break
        case let .setCalendarStyle(isStyle):
            newState.isStyle = isStyle
        case let .setInstructorItems(items):
            print("Instructor items: \(items)")
        }
        return newState
    }
    
}
