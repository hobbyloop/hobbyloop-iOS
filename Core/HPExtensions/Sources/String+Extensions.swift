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
    
}


public extension StringProtocol {
    
    var digitsOnly: String {
        return String(filter(("0"..."9").contains))
    }
    
}
