//
//  HomeSection.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/10.
//

import Foundation

import RxDataSources


public enum HomeType: String, Equatable {
    case userInfoType
    case calendarType
    case selectCategoryType
    case scheduleType
    case explanationType
    case exerciseType
    case benefitsType
}


//MARK: Section

public enum HomeSection: SectionModelType {
    case userInfoClass([HomeSectionItem])
    case selectCategoryClass([HomeSectionItem])
    case advertisementClass([HomeSectionItem])
    case exerciseClass([HomeSectionItem])
    case weekHotTicketClass([HomeSectionItem])
    
    public var items: [HomeSectionItem] {
        switch self {
        case let .userInfoClass(items): return items
        case let .selectCategoryClass(items): return items
        case let .advertisementClass(items): return items
        case let .exerciseClass(items): return items
        case let .weekHotTicketClass(items): return items
            
        }
    }
    
    public init(original: HomeSection, items: [HomeSectionItem]) {
        switch original {
        case .userInfoClass: self = .userInfoClass(items)
        case .selectCategoryClass: self = .selectCategoryClass(items)
        case .advertisementClass: self = .advertisementClass(items)
        case .exerciseClass: self = .exerciseClass(items)
        case .weekHotTicketClass: self = .weekHotTicketClass(items)
        }
    }
    
    
}

//MARK: Item
public enum HomeSectionItem {
    case userInfoClassItem
    case selectCategoryClassItem
    case advertisementClassItem
    case exerciseClassItem
    case weekHotTicketClassItem
}



extension HomeSection {
    
    func getSectionType() -> HomeType {
        
        switch self {
        case .userInfoClass: return .userInfoType
        case .selectCategoryClass: return .selectCategoryType
        case .advertisementClass: return .scheduleType
        case .exerciseClass: return .exerciseType
        case .weekHotTicketClass: return .benefitsType
        }
        
    }
}
