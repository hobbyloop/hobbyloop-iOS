//
//  DailyType.swift
//  HPCommon
//
//  Created by 김진우 on 2023/08/25.
//

import Foundation

public struct DailyTime {
    /// ex) 월, 화, 수
    let day: String
    /// ex) 11:30 ~ 21: 30
    let time: String
    
    public init(day: String, time: String) {
        self.day = day
        self.time = time
    }
}
