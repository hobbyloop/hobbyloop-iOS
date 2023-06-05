//
//  String+Extensions.swift
//  HPExtensions
//
//  Created by Kim dohyun on 2023/06/05.
//

import Foundation


public extension String {
    
    
    func toPhoneNumber() -> String {
        let digits = digitsOnly
        if digits.count == 11 {
            return digits.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: nil)
        } else {
            return self
        }
    }
    
    
    func birthdayToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        if let date = dateFormatter.date(from: self) {
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let newDateString = newDateFormatter.string(from: date)
            return newDateString
        } else {
            return ""
        }
    }
    
    func birthdayToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        guard let newDate = dateFormatter.date(from: self) else { return Date() }
        return newDate
    }
    
}


public extension StringProtocol {
    
    var digitsOnly: String {
        return String(filter(("0"..."9").contains))
    }
    
}
