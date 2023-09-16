//
//  TicketReservationSection.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/16.
//

import Foundation


import RxDataSources


public enum TicketReservationSection: SectionModelType {
    case groupLesson([TicketReservationItem])
    case personLesson([TicketReservationItem])
    
    
    public var items: [TicketReservationItem] {
        switch self {
        case let .groupLesson(items): return items
        case let .personLesson(items): return items
        }
    }
    
    public init(original: TicketReservationSection, items: [TicketReservationItem]) {
        switch original {
        case .groupLesson: self = .groupLesson(items)
        case .personLesson: self = .personLesson(items)
        }
    }
    
}


public enum TicketReservationItem {
    case ticketItem
}
