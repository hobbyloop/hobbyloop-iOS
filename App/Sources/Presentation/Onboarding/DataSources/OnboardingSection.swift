//
//  OnboardingSection.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/06/28.
//

import Foundation

import RxDataSources

public enum OnboardingType: String, Equatable {
    case onboardingType
}


//MARK: Section
public enum OnboardingSection: SectionModelType {
    case Onboarding([OnboardingSectionItem])
    
    public var items: [OnboardingSectionItem] {
        switch self {
        case let .Onboarding(items): return items
        }
    }
    
    public init(original: OnboardingSection, items: [OnboardingSectionItem]) {
        switch original {
        case .Onboarding: self = .Onboarding(items)
        }
    }
    
    
}

//MARK: Item
public enum OnboardingSectionItem {
    case OnboardingItems(OnboardingCellReactor)
}


extension OnboardingSection {
    
    func getSectionType() -> OnboardingType {
        switch self {
        case .Onboarding: return .onboardingType
        }
    }
    
}



