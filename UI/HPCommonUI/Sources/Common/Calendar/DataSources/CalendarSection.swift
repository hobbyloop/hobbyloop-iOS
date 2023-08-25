//
//  CalendarSection.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/23.
//

import Foundation

import RxDataSources

public enum CalendarType: String, Equatable {
    case calendarType
    case ticketType
}



public enum CalendarSection: SectionModelType {
    case calendar([CalendarSectionItem])
    case ticket([CalendarSectionItem])
    
    public var items: [CalendarSectionItem] {
        switch self {
        case let .calendar(items): return items
        case let .ticket(items): return items
        }
    }
    
    public init(original: CalendarSection, items: [CalendarSectionItem]) {
        switch original {
        case .calendar: self = .calendar(items)
        case .ticket: self = .ticket(items)
        }
    }
    
    public func getSectionType() -> CalendarType {
        switch self {
        case .calendar: return .calendarType
        case .ticket: return .ticketType
            
        }
        
    }
    
}


public enum CalendarSectionItem {
    case calendarItem(HPCalendarDayCellReactor)
    case ticketItem
    
}
