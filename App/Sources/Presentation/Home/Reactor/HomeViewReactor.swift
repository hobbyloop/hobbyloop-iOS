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
                .schedulClass([
                    .schedulClassItem
                ]),
                .explanationClass([
                    .explanationClassItem
                ]),
                .exerciseClass([
                    .exerciseClassItem
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
            let scheduleIndex = self.getIndex(section: .schedulClass([]))
            let explanationIndex = self.getIndex(section: .explanationClass([]))
            let exerciseIndex = self.getIndex(section: .exerciseClass([]))
            
            //TODO: Server API 구현시 데이터 Response 값으로 Cell Configure
            newState.section[scheduleIndex] = .schedulClass([HomeSectionItem.schedulClassItem])
            newState.section[explanationIndex] = .explanationClass([HomeSectionItem.explanationClassItem])
            newState.section[exerciseIndex] = .exerciseClass([
                HomeSectionItem.exerciseClassItem,
                HomeSectionItem.exerciseClassItem,
                HomeSectionItem.exerciseClassItem,
                HomeSectionItem.exerciseClassItem,
                HomeSectionItem.exerciseClassItem
                
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





