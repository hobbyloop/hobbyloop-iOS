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
}


//MARK: Section

public enum HomeSection: SectionModelType {
    case schedulClass([HomeSectionItem])
    case explanationClass([HomeSectionItem])
    case exerciseClass([HomeSectionItem])
    
    public var items: [HomeSectionItem] {
        switch self {
        case let .schedulClass(items): return items
        case let .explanationClass(items): return items
        case let .exerciseClass(items): return items
        }
    }
    
    public init(original: HomeSection, items: [HomeSectionItem]) {
        switch original {
        case .schedulClass: self = .schedulClass(items)
        case .explanationClass: self = .explanationClass(items)
        case .exerciseClass: self = .exerciseClass(items)
        }
    }
    
    
}

//MARK: Item
public enum HomeSectionItem {
    case schedulClassItem
    case explanationClassItem
    case exerciseClassItem
}



extension HomeSection {
    
    func getSectionType() -> HomeType {
        
        switch self {
        case .schedulClass: return .scheduleType
        case .explanationClass: return .explanationType
        case .exerciseClass: return .exerciseType
        }
        
    }
}
