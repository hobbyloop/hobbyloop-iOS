//
//  HPCouponViewReactor.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/10/11.
//

import Foundation

import ReactorKit

public class HPCouponViewReactor: Reactor {
    
    public var initialState: State
    private var sectionType: HPCouponType
    
    public enum Action {
        case loadView
    }
    
    public struct State {
        @Pulse var couponSection: [HPCouponSection]
    }
    
    
    public init(sectionType: HPCouponType) {
        self.sectionType = sectionType
        if sectionType == .ticket {
            self.initialState = State(
                couponSection: [
                    .ticket([
                        .ticketItem(
                            HPCouponCellReactor(
                                currentIndex: 0,
                                numberOfPages: 4,
                                couponTitle: "발란스 스튜디오",
                                couponCount: 10,
                                couponDate: Date(),
                                couponType: .gold
                            )
                        ),
                        .ticketItem(
                            HPCouponCellReactor(
                                currentIndex: 1,
                                numberOfPages: 4,
                                couponTitle: "발란스 스튜디오",
                                couponCount: 10,
                                couponDate: Date(),
                                couponType: .emerald
                            )
                        ),
                        .ticketItem(
                            HPCouponCellReactor(
                                currentIndex: 2,
                                numberOfPages: 4,
                                couponTitle: "발란스 스튜디오",
                                couponCount: 10,
                                couponDate: Date(),
                                couponType: .master
                            )
                        ),
                        .ticketItem(
                            HPCouponCellReactor(
                                currentIndex: 3,
                                numberOfPages: 4,
                                couponTitle: "발란스 스튜디오",
                                couponCount: 10,
                                couponDate: Date(),
                                couponType: .season
                            )
                        )
                    ]
                    )
                ]
            )
        } else {
            self.initialState = State(
                couponSection: [
                    .loopPass([.loopPassItem])
                ]
            )
        }
    }
    
    
}
