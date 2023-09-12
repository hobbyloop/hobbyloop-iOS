//
//  Date+Extensions.swift
//  HPExtensions
//
//  Created by Kim dohyun on 2023/05/28.
//

import Foundation


public extension Date {
    
    
    var day: Int {
        return Calendar.current.component(.day, from: nowDate)
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: nowDate)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: nowDate)
    }
    
    
    var weekday: Int {
        return Calendar.current.component(.weekday, from: nowDate)
    }
    
    
    
    var components: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day],from: self)
    }
    
    var nowDate: Date {
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var rangeOfdays: Int {
        return Calendar.current.range(of: .day, in: .month, for: nowDate)?.count ?? Int()
    }
    
    
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
    
    func dateCompare(fromDate: Date) -> Bool {
        let result: ComparisonResult = self.compare(fromDate)
        
        switch result {
        case .orderedDescending:
            return false
        default:
            return true
        }
        
    }
    
}
