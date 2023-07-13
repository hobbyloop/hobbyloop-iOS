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
            section: []
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            return .just(.setLoading(true))
            
        }
        
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        }
        
        return newState
    }
    
}
