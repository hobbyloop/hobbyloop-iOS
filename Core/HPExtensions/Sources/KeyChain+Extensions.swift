//
//  KeyChain+Extensions.swift
//  HPExtensions
//
//  Created by Kim dohyun on 2023/11/02.
//

import Foundation

import KeychainAccess

public enum KeychainKeys: String {
    case accessToken
    case refreshToken
    case expiredAt
    case accountType
}


extension Keychain {
    public func set(_ value: String, key: KeychainKeys, ignoringAttributeSynchronizable: Bool = true) throws {
        guard let data = value.data(using: .utf8, allowLossyConversion: false) else {
            print("failed to convert string to data")
            throw Status.conversionError
        }
        try set(data, key: key.rawValue, ignoringAttributeSynchronizable: ignoringAttributeSynchronizable)
    }
    
    
}
