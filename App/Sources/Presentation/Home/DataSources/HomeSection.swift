//
//  HomeSection.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/10.
//

import Foundation

import RxDataSources


public enum HomeType: String, Equatable {
    case scheduleType
    case explanationType
    case exerciseType
    case benefitsType
}


//MARK: Section

public enum HomeSection: SectionModelType {
    case schedulClass([HomeSectionItem])
    case explanationClass([HomeSectionItem])
    case exerciseClass([HomeSectionItem])
    case benefitsClass([HomeSectionItem])
    
    public var items: [HomeSectionItem] {
        switch self {
        case let .schedulClass(items): return items
        case let .explanationClass(items): return items
        case let .exerciseClass(items): return items
        case let .benefitsClass(items): return items
            
        }
    }
    
    public init(original: HomeSection, items: [HomeSectionItem]) {
        switch original {
        case .schedulClass: self = .schedulClass(items)
        case .explanationClass: self = .explanationClass(items)
        case .exerciseClass: self = .exerciseClass(items)
        case .benefitsClass: self = .benefitsClass(items)
        }
    }
    
    
}

//MARK: Item
public enum HomeSectionItem {
    case schedulClassItem
    case explanationClassItem
    case exerciseClassItem
    case benefitsClassItem
}



extension HomeSection {
    
    func getSectionType() -> HomeType {
        
        switch self {
        case .schedulClass: return .scheduleType
        case .explanationClass: return .explanationType
        case .exerciseClass: return .exerciseType
        case .benefitsClass: return .benefitsType
        }
        
    }
}
