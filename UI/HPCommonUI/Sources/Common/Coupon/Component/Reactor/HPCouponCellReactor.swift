//
//  HPCouponCellReactor.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/10/11.
//

import Foundation
import ReactorKit


public enum HPTicketType: String {
    case gold = "one_month_coupon"
    case sapphire = "three_month_coupon"
    case master = "six_month_coupon"
    case emerald = "nine_month_coupon"
    case ruby = "twelve_month_coupon"
    case season = "season_coupon"
}

public final class HPCouponCellReactor: Reactor {
    
    public var initialState: State
    
    public typealias Action = NoAction
    
    public struct State {
        var currentIndex: Int
        var numberOfPages: Int
        var couponTitle: String
        var couponCount: Int
        var couponDate: Date
        var couponType: HPTicketType
    }
    
    
    public init(
        currentIndex: Int,
        numberOfPages: Int,
        couponTitle: String,
        couponCount: Int,
        couponDate: Date,
        couponType: HPTicketType
    ) {
        self.initialState = State(
            currentIndex: currentIndex,
            numberOfPages: numberOfPages,
            couponTitle: couponTitle,
            couponCount: couponCount,
            couponDate: couponDate,
            couponType: couponType
        )
        
    }
    
    
    
    
    
}
