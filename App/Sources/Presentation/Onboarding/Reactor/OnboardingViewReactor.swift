//
//  OnboardingViewReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/06/28.
//

import Foundation

import HPDomain
import RxSwift
import ReactorKit



public final class OnboardingViewReactor: Reactor {
    
    // MARK: Property
    public var onboardingRepository: OnboardingRepo
    public var onboardingEntity: Onboarding
    
    public var initialState: State
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setOnboardingItem
    }
    
    public struct State {
        var isLoading: Bool
        @Pulse var section: [OnboardingSection]
    }
    
    public init(onboardingRepository: OnboardingRepo, onboardingEntity: Onboarding) {
        self.onboardingRepository = onboardingRepository
        self.onboardingEntity = onboardingEntity
        self.initialState = State(
            isLoading: false,
            section: [
                .Onboarding([])
            ]
        )
    }
    
    
    
    // MARK: SideEffect
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            return .concat(
                startLoading,
                .just(.setOnboardingItem),
                endLoading
            )
        }
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case .setOnboardingItem:
            let onboardingIndex = self.getIndex(section: .Onboarding([]))
            newState.section[onboardingIndex] = self.onboardingRepository.responseOnboardingItems(items: self.onboardingEntity)
        }
        
        return newState
    }
    
}



private extension OnboardingViewReactor {
    
    func getIndex(section: OnboardingSection) -> Int {
        var index: Int = 0
        
        for i in 0 ..< self.currentState.section.count where self.currentState.section[i].getSectionType() == section.getSectionType() {
            index = i
        }
        
        return index
    }
}
