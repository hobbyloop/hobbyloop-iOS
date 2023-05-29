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
    
    /// 암호화  처리를 실행하는 메서드
    ///  - note: APIKey, AccessToken, RefreshToekn 등을 암호화 처리하기 위한 메서드
    ///  - parameters: 암호화 처리할 String Type 의 문자열
    public static func makeEncryption(_ cipher: String) throws -> String {
        guard !cipher.isEmpty else { return "" }
        return try makeAESInstance().encrypt(cipher.bytes).toBase64()
    }
    
    /// 복호화 처리를 실행하는 메서드
    ///  - note: APIKey, AccessToken, RefreshToekn 등을 복호화 처리하기 위한 메서드
    ///  - parameters: 복호화 처리할 String Type 의 문자열
    public static func makeDecryption(_ encoded: String) throws -> String {
        let data = Data(base64Encoded: encoded)
        
        guard let data else { return "" }
        
        let bytes = data.bytes
        let decoded = try makeAESInstance().decrypt(bytes)
        
        return String(bytes: decoded, encoding: .utf8) ?? ""
    }
    
    /// 고급 암호화 표준(AES 256, 192, 128) 계열을 생성하기 위한 인스턴스
    ///  - note: 표준 암호화 (AES 256, 192, 128) 계열을 생성하기 위한 인스턴스 생성 메서드
    ///  - parameters: none Parameters
    public static func makeAESInstance() throws -> AES {
        let keyDecoded: Array<UInt8> = Array(defaultKey.utf8)
        let ivDecoded: Array<UInt8> = Array(defaultIV.utf8)
        
        return try AES(key: keyDecoded, blockMode: CBC(iv: ivDecoded), padding: .pkcs5)
    }
    
}
