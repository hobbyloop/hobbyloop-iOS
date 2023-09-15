//
//  TicketSelectSection.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/15.
//

import Foundation

import RxDataSources


public enum TicketSelectSection: SectionModelType {
    case reservationTicket([TicketSelectItem])
    case reservationTicketClass([TicketSelectItem])
    
    //TODO: Table Style insetGrouped를 통해 Section 단위로 model 뿌려줄지 Item 단위로 Model 뿌려 줄지 고민
    public var items: [TicketSelectItem] {
        switch self {
        case let .reservationTicket(items): return items
        case let .reservationTicketClass(items): return items
        }
    }
    
    public init(original: TicketSelectSection, items: [TicketSelectItem]) {
        switch original {
        case .reservationTicket: self = .reservationTicket(items)
        case .reservationTicketClass: self = .reservationTicketClass(items)
        }
    }
}



//MARK: Item
public enum TicketSelectItem {
    case reservationTicketItem
}
