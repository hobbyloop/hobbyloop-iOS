//
//  PointViewReactor.swift
//  Hobbyloop
//
//  Created by 김남건 on 6/28/24.
//

import Foundation
import ReactorKit
import HPDomain

public final class PointViewReactor: Reactor {
    public var initialState = State()
    public var pointRepository: PointViewRepo
    
    public enum Section {
        case totalPoints
        case expiredPoints
    }
    
    public struct State {
        var isLoading = false
        @Pulse var pointHistoryData: PointHistoryData? = nil
        var section: Section = .totalPoints
    }
    
    public enum Action {
        case viewDidLoad
        case didTapTotalPointButton
        case didTapExpiredPointButton
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setPointHistoryData(PointHistoryData)
        case setSection(Section)
    }
    
    init(pointRepository: PointViewRepo) {
        self.pointRepository = pointRepository
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .concat([
                .just(.setLoading(true)),
                pointRepository.getPointHisotryData(),
                .just(.setLoading(false))
            ])
        case .didTapTotalPointButton:
            return .just(.setSection(.totalPoints))
        case .didTapExpiredPointButton:
            return .just(.setSection(.expiredPoints))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .setPointHistoryData(let pointHistoryData):
            newState.pointHistoryData = pointHistoryData
        case .setSection(let section):
            newState.section = section
        }
        
        return newState
    }
}
