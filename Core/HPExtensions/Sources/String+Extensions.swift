//
//  String+Extensions.swift
//  HPExtensions
//
//  Created by 김남건 on 6/19/24.
//

import Foundation

extension String {
    /// 휴대폰 번호 하이픈 추가
    public var withHypen: String {
        var stringWithHypen: String = self
        
        stringWithHypen.insert("-", at: stringWithHypen.index(stringWithHypen.startIndex, offsetBy: 3))
        stringWithHypen.insert("-", at: stringWithHypen.index(stringWithHypen.endIndex, offsetBy: -4))
        
        return stringWithHypen
    }
}
