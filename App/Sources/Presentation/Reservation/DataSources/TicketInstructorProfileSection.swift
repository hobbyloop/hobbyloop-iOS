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
    case instructorCalendar([TicketInstructorProfileItem])
    case instructorProfile([TicketInstructorProfileItem])
    case instructorIntroduce([TicketInstructorProfileItem])
    case instructorSchedule([TicketInstructorProfileItem])
    
    public var items: [TicketInstructorProfileItem] {
        switch self {
        case let .instructorCalendar(items): return items
        case let .instructorProfile(items): return items
        case let .instructorIntroduce(items): return items
        case let .instructorSchedule(items): return items
        }
    }
    public init(original: TicketInstructorProfileSection, items: [TicketInstructorProfileItem]) {
        switch original {
        case .instructorCalendar: self = .instructorCalendar(items)
        case .instructorProfile: self = .instructorProfile(items)
        case .instructorIntroduce: self = .instructorIntroduce(items)
        case .instructorSchedule: self = .instructorSchedule(items)
        }
    }
    
}

/**
  수업 예약 강사 프로필 Item
 */
public enum TicketInstructorProfileItem {
    case instructorCalendarItem(TicketCalendarCellReactor)
    case instructorProfileItem(TicketInstructorProfileCellReactor)
    case instructorIntroduceItem
    case instructorScheduleItem
    
}
