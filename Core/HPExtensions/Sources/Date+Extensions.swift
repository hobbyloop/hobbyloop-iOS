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
    
    func covertToExpiredString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter.string(from: self)
    }
    
    func converToExpiredoDate() -> Date {
        let dateToString = self.covertToExpiredString()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        return dateFormatter.date(from: dateToString) ?? Date()
    }
    
    func dateCompare(fromDate: Date) -> String {
        let result: ComparisonResult = self.compare(fromDate)
        
        switch result {
        case .orderedDescending:
            return "Past"
        case .orderedSame:
            return "Same"
        default:
            return "Future"
        }
        
    }
    
}
