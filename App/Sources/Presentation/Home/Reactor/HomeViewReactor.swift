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
    public var initialState: State
    private var homeRepository: HomeViewRepo
    
    //MARK: Action
    public enum Action {
    }
    
    public enum Mutation {
        case none
    }
    
    //MARK: State
    public struct State {
        
    }
    
    init(homeRepository: HomeViewRepo) {
        self.homeRepository = homeRepository
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        return Observable.just(.none)
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        return State()
    }
    
}
