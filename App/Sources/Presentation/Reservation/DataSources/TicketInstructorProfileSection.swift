//
//  TicketInstructorProfileSection.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/20.
//

import Foundation

import RxDataSources

/**
 수업 예약 강사 프로필 Section
 
 */
public enum TicketInstructorProfileSection: SectionModelType {
    case instructorProfile([TicketInstructorProfileItem])
    
    public var items: [TicketInstructorProfileItem] {
        switch self {
        case let .instructorProfile(items): return items
        }
    }
    public init(original: TicketInstructorProfileSection, items: [TicketInstructorProfileItem]) {
        switch original {
        case .instructorProfile: self = .instructorProfile(items)
        }
    }
    
}

/**
  수업 예약 강사 프로필 Item
 */
public enum TicketInstructorProfileItem {
    case instructorProfileItem(TicketInstructorProfileCellReactor)
    
}


public enum TicketScheduleSection: SectionModelType {
    case instructorSchedule([TicketScheduleItem])
    
    public var items: [TicketScheduleItem] {
        switch self {
        case let .instructorSchedule(items): return items
        }
    }
    
    public init(original: TicketScheduleSection, items: [TicketScheduleItem]) {
        switch original {
        case .instructorSchedule: self = .instructorSchedule(items)
        }
    }
}


public enum TicketScheduleItem {
    case instructorScheduleItem
}
