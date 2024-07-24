//
//  Int+Extensions.swift
//  HPExtensions
//
//  Created by 김남건 on 6/28/24.
//

import Foundation

public extension Int {
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
