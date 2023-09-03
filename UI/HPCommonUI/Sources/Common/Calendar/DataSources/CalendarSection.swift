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
}



public enum CalendarSection: SectionModelType {
    case calendar([CalendarSectionItem])
    
    public var items: [CalendarSectionItem] {
        switch self {
        case let .calendar(items): return items
        }
    }
    
    public init(original: CalendarSection, items: [CalendarSectionItem]) {
        switch original {
        case .calendar: self = .calendar(items)
        }
    }
    
    public func getSectionType() -> CalendarType {
        switch self {
        case .calendar: return .calendarType
        }
        
    }
    
}


public enum CalendarSectionItem {
    case calendarItem(HPCalendarDayCellReactor)
}
