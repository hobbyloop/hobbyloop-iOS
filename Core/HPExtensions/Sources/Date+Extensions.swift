//
//  Date+Extensions.swift
//  HPExtensions
//
//  Created by Kim dohyun on 2023/05/28.
//

import Foundation


public extension Date {
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: self)
    }
    
}
