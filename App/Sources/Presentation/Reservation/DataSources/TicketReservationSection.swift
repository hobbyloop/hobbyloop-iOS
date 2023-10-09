//
//  TicketReservationSection.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/16.
//

import Foundation


import RxDataSources


public enum TicketReservationSection: SectionModelType {
    case reservationTicket([TicketReservationItem])
    case reservationNotice([TicketReservationItem])
    case reservationType([TicketReservationItem])
    case reservationUserInfo([TicketReservationItem])
    
    
    public var items: [TicketReservationItem] {
        switch self {
        case let .reservationTicket(items): return items
        case let .reservationNotice(items): return items
        case let .reservationType(items): return items
        case let .reservationUserInfo(items): return items
        }
    }
    
    public init(original: TicketReservationSection, items: [TicketReservationItem]) {
        switch original {
        case .reservationTicket: self = .reservationTicket(items)
        case .reservationNotice: self = .reservationNotice(items)
        case .reservationType: self = .reservationType(items)
        case .reservationUserInfo: self = .reservationUserInfo(items)
        }
    }
    
}


public enum TicketReservationItem {
    case reservationTicketItem
    case reservationNoticeItem
    case reservationTypeItem
    case reservationUserInfoItem

    
}
