//
//  DummyCoupon.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/06.
//

import Foundation

/// 이용권 UI에서 임시적으로 활용할 데이터 모델
public struct DummyCoupon {
    let companyName: String
    var count: Int
    let start: Date
    let end: Date
    
    public init(companyName: String, count: Int, start: Date, end: Date) {
        self.companyName = companyName
        self.count = count
        self.start = start
        self.end = end
    }
}
