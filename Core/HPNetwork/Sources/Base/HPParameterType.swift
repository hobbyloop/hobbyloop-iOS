//
//  HPParameterType.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/06/01.
//

import Foundation


public enum HPParameterType {
    case query(_ parameter: Encodable?)
    case body(_ parameter: Encodable?)
    case none
}


extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any] else { return [:] }
        return dictionaryData
    }
}
