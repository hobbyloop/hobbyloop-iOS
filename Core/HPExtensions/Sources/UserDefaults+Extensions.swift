//
//  UserDefaults+Extensions.swift
//  HPExtensions
//
//  Created by Kim dohyun on 2023/05/30.
//

import Foundation



public enum UserDefaultsKeys: String {
    case accessId
    case userInfo
    case expiredAt
}


public extension UserDefaults {
    
    func set(_ value: Any?, forKey: UserDefaultsKeys) {
        set(value, forKey: forKey.rawValue)
    }
    
    
    func string(forKey: UserDefaultsKeys) -> String {
        return string(forKey: forKey.rawValue) ?? ""
    }
    
    func array(forKey: UserDefaultsKeys) -> [Any] {
        return array(forKey: forKey.rawValue) ?? []
    }
    
    func dictionary(forKey: UserDefaultsKeys) -> [String: Any]? {
        return dictionary(forKey: forKey.rawValue)
    }
    
    func data(forKey: UserDefaultsKeys) -> Data? {
        return data(forKey: forKey.rawValue)
    }
    
    func stringArray(forKey: UserDefaultsKeys) -> [String] {
        return stringArray(forKey: forKey.rawValue) ?? []
    }
    
    func integer(forKey: UserDefaultsKeys) -> Int {
        return integer(forKey: forKey.rawValue)
    }
    
    func float(forKey: UserDefaultsKeys) -> Float {
        return float(forKey: forKey.rawValue)
    }
    
    func double(forKey: UserDefaultsKeys) -> Double {
        return double(forKey: forKey.rawValue)
    }
    
    
    func date(forKey: UserDefaultsKeys) -> Date? {
        return object(forKey: forKey.rawValue) as? Date
    }
    
    func bool(forKey: UserDefaultsKeys) -> Bool {
        return bool(forKey: forKey.rawValue)
    }
    
    func object(forKey: UserDefaultsKeys) -> Any? {
        return object(forKey: forKey.rawValue)
    }
    
    func remove(forKey: UserDefaultsKeys) {
        return removeObject(forKey: forKey.rawValue)
    }
    
    
}
