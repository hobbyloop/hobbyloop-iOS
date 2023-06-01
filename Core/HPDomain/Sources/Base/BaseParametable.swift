//
//  BaseParametable.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/06/01.
//

import Foundation

public protocol Parameterable where Self: Encodable {
    func toJSONString() -> String
}

public extension Parameterable {
    func toJSONString() -> String {
        do {
            let json = try JSONEncoder().encode(self)
            return String(data: json, encoding: .utf8) ?? ""
        } catch {
            debugPrint("BaseParametable Erorr: \(error.localizedDescription)")
        }
        return ""
    }
}
