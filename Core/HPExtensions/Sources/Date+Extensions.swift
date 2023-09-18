//
//  Date+Extensions.swift
//  HPExtensions
//
//  Created by Kim dohyun on 2023/05/28.
//

import Foundation


public extension Date {
    
    var calendar: Calendar {
        return Calendar.current
    }
    
    var day: Int {
        return self.calendar.component(.day, from: .now)
    }
    
    var year: Int {
        return self.calendar.component(.year, from: nowDate)
    }
    
    var month: Int {
        return self.calendar.component(.month, from: nowDate)
    }
    
    
    var weekday: Int {
        return self.calendar.component(.weekday, from: nowDate)
    }
    
    
    var components: DateComponents {
        return self.calendar.dateComponents([.year, .month], from: self)
    }
    
    var nowDate: Date {
        return self.calendar.date(from: components) ?? Date()
    }
    
    var rangeOfdays: Int {
        return self.calendar.range(of: .day, in: .month, for: nowDate)?.count ?? Int()
    }
    
    //TODO: Protocol에 넣을지, Date Extension 넣을지 고민 
    func getWeekDays(identifier: String) -> [String] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: identifier)
        
        return calendar.shortWeekdaySymbols
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
