//
//  Data+Extensions.swift
//  HPExtensions
//
//  Created by Kim dohyun on 2023/11/01.
//

import Foundation


extension Data {
    public var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }
        
        return prettyPrintedString as String
    }
}

