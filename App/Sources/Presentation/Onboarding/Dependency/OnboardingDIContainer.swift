//
//  OnboardingDIContainer.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/06/28.
//

import HPCommon


final class OnboardingDIContainer: DIContainer {

    typealias ViewController = OnboardingViewController
    typealias Repository = Optional
    typealias Reactor = Optional
    
    
    func makeViewController() -> OnboardingViewController {
        return OnboardingViewController()
    }
    
    func makeRepository() -> Repository<Any> {
        return nil
    }
    
    func makeReactor() -> Reactor<Any> {
        return nil
    }
    
    
    
    
    
    
}

