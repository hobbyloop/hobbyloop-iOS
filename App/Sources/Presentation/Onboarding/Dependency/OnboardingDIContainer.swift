//
//  OnboardingDIContainer.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/06/28.
//

import HPCommon
import HPDomain

final class OnboardingDIContainer: DIContainer {

    typealias ViewController = OnboardingViewController
    typealias Repository = OnboardingRepo
    typealias Reactor = OnboardingViewReactor
    
    
    func makeViewController() -> OnboardingViewController {
        return OnboardingViewController(reactor: makeReactor())
    }
    
    func makeRepository() -> OnboardingRepo {
        return OnboardingViewRepository()
    }
    
    func makeReactor() -> OnboardingViewReactor {
        return OnboardingViewReactor(onboardingRepository: makeRepository(), onboardingEntity: Onboarding())
    }
    
    
    
    
    
    
}

