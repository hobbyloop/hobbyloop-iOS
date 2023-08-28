//
//  HomeViewReactor.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/25.
//

import Foundation

import HPExtensions
import ReactorKit
import RxSwift

final class HomeViewReactor: Reactor {
    
    //MARK: Property
    public var initialState: State
    private var homeRepository: HomeViewRepo
    
    //MARK: Action
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setEmptyClassItem
    }
    
    //MARK: State
    public struct State {
        var isLoading: Bool
        @Pulse var section: [HomeSection]
    }
    
    init(homeRepository: HomeViewRepo) {
        self.homeRepository = homeRepository
        self.initialState = State(
            isLoading: false,
            section: [
                .userInfoClass([
                    .userInfoClassItem
                ]),
                
                .calendarClass([
                    .calendarClassItem
                ]),
                
                .ticketClass([
                    .ticketClassItem
                ]),
                
                .schedulClass([
                    .schedulClassItem
                ]),
                .explanationClass([
                    .explanationClassItem
                ]),
                .exerciseClass([
                    .exerciseClassItem
                ]),
                .benefitsClass([
                    .benefitsClassItem
                ])
            ]
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            
            return .concat(
                startLoading,
                .just(.setEmptyClassItem),
                endLoading
            )
            
        }
        
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case .setEmptyClassItem:
            let userIndex = self.getIndex(section: .userInfoClass([]))
            let ticketIndex = self.getIndex(section: .ticketClass([]))
            let calendarIndex = self.getIndex(section: .calendarClass([]))
            let scheduleIndex = self.getIndex(section: .schedulClass([]))
            let explanationIndex = self.getIndex(section: .explanationClass([]))
            let exerciseIndex = self.getIndex(section: .exerciseClass([]))
            let benefitsIndex = self.getIndex(section: .benefitsClass([]))
            
            //TODO: Server API 구현시 데이터 Response 값으로 Cell Configure
            newState.section[userIndex] = .userInfoClass([HomeSectionItem.userInfoClassItem])
            newState.section[calendarIndex] = .calendarClass([HomeSectionItem.calendarClassItem])
            newState.section[ticketIndex] = .ticketClass([HomeSectionItem.ticketClassItem])
            newState.section[scheduleIndex] = .schedulClass([HomeSectionItem.schedulClassItem])
            newState.section[explanationIndex] = .explanationClass([HomeSectionItem.explanationClassItem])
            newState.section[exerciseIndex] = .exerciseClass([
                HomeSectionItem.exerciseClassItem,
                HomeSectionItem.exerciseClassItem,
                HomeSectionItem.exerciseClassItem,
                HomeSectionItem.exerciseClassItem,
                HomeSectionItem.exerciseClassItem
                
            ])
            newState.section[benefitsIndex] = .benefitsClass([
                HomeSectionItem.benefitsClassItem,
                HomeSectionItem.benefitsClassItem,
                HomeSectionItem.benefitsClassItem,
                HomeSectionItem.benefitsClassItem,
                HomeSectionItem.benefitsClassItem
            ])
        }
        
        return newState
    }
    
}



private extension HomeViewReactor {
    
    func getIndex(section: HomeSection) -> Int {
        
        var index: Int = 0
        
        for i in 0 ..< self.currentState.section.count where self.currentState.section[i].getSectionType() == section.getSectionType() {
            index = i
        }
        
        return index
        
    }
    
}





