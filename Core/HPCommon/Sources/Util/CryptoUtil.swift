//
//  CryptoUtil.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/05/29.
//

import Foundation
import CryptoSwift

private protocol CrpytoInterface {
    static var defaultKey: String { get }
    static var defaultIV: String { get }
    
    static func makeEncryption(_ cipher: String) throws -> String
    static func makeDecryption(_ encoded: String) throws -> String
    static func makeAESInstance() throws -> AES

}


public final class CryptoUtil: CrpytoInterface {
    
    /// defaultKey: 32 바이트
    /// defaultIV: 16 바이트
    static let defaultKey: String = "01234567890123450123456789012345"
    static let defaultIV: String = "0123456789012345"
    
    public static func makeEncryption(_ cipher: String) throws -> String {
        guard !cipher.isEmpty else { return "" }
        return try makeAESInstance().encrypt(cipher.bytes).toBase64()
    }
    
    public static func makeDecryption(_ encoded: String) throws -> String {
        let data = Data(base64Encoded: encoded)
        
        guard let data else { return "" }
        
        let bytes = data.bytes
        let decoded = try makeAESInstance().decrypt(bytes)
        
        return String(bytes: decoded, encoding: .utf8) ?? ""
    }
    
    public static func makeAESInstance() throws -> AES {
        let keyDecoded: Array<UInt8> = Array(defaultKey.utf8)
        let ivDecoded: Array<UInt8> = Array(defaultIV.utf8)
        
        return try AES(key: keyDecoded, blockMode: CBC(iv: ivDecoded), padding: .pkcs5)
    }
    
}
