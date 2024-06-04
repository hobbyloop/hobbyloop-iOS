//
//  DummyCoupon.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/06.
//

import Foundation

/// 이용권 UI에서 임시적으로 활용할 데이터 모델
public struct DummyCoupon {
    let studioName: String
    let couponName: String
    var count: Int
    let maxCount: Int
    let duration: Int?
    
    public init(studioName: String, couponName: String, count: Int, maxCount: Int, duration: Int?) {
        self.studioName = studioName
        self.couponName = couponName
        self.count = count
        self.maxCount = maxCount
        self.duration = duration
    }
}
