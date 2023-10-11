//
//  HPCouponSection.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/10/11.
//

import Foundation

import RxDataSources


public enum HPCouponType {
    case loopPass
    case ticket
}


public enum HPCouponSection: SectionModelType {
    case loopPass([HPCouponSectionItem])
    case ticket([HPCouponSectionItem])
    
    
    
    public var items: [HPCouponSectionItem] {
        switch self {
        case let .loopPass(items): return items
        case let .ticket(items): return items
        }
    }
    
    public init(original: HPCouponSection, items: [HPCouponSectionItem]) {
        switch original {
        case .loopPass: self = .loopPass(items)
        case .ticket: self = .ticket(items)
        }
    }
    
}


public enum HPCouponSectionItem {
    case loopPassItem
    case ticketItem(HPCouponCellReactor)
}
