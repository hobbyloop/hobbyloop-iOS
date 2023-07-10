//
//  HomeSection.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/10.
//

import Foundation

import RxDataSources

//MARK: Section

public enum HomeSection: SectionModelType {
    case schedulClass([HomeSectionItem])
    case onboardingClass([HomeSectionItem])
    
    public var items: [HomeSectionItem] {
        switch self {
        case let .schedulClass(items): return items
        case let .onboardingClass(items): return items
        }
    }
    
    public init(original: HomeSection, items: [HomeSectionItem]) {
        switch original {
        case .schedulClass: self = .schedulClass(items)
        case .onboardingClass: self = .onboardingClass(items)
        }
    }
    
    
}

//MARK: Item
public enum HomeSectionItem {
    case schedulClassItem
    case onboardingClassItem
    
}

