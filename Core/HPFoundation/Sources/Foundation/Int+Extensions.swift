//
//  Int+Extensions.swift
//  HPFoundation
//
//  Created by 김진우 on 10/26/23.
//

import Foundation

public extension Int {
    func numberFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
