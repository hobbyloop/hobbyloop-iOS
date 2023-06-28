//
//  OnboardingViewRepository.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/06/28.
//

import Foundation

import HPDomain

public protocol OnboardingRepo {
    func responseOnboardingItems(items: Onboarding) -> OnboardingSection
}



public final class OnboardingViewRepository: OnboardingRepo {
    
    public func responseOnboardingItems(items: Onboarding) -> OnboardingSection {
        
        var onboardingSectionItems: [OnboardingSectionItem] = []
        
        for i in 0 ..< 4 {
            onboardingSectionItems.append(.OnboardingItems(OnboardingCellReactor(onboardingImage: items.image[i], onboardingTitle: items.title[i])))
        }        
        
        return OnboardingSection.Onboarding(onboardingSectionItems)
    }
    
}
