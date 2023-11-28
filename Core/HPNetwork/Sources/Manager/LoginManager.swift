//
//  LoginManager.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/10/04.
//

import Foundation

import HPExtensions
import HPDomain
import Alamofire
import KeychainAccess

public protocol Authenticationable {
    var keychain: Keychain { get }
    func isLogin() -> Bool
    func updateTokens(accessToken: String, refreshToken: String)
    func updateAccessToken(accessToken: String)
    func readToken(key: KeychainKeys) -> String
    func removeToken(key: KeychainKeys)
    func removeAll()
}

public final class LoginManager: Authenticationable {
    public static let shared: LoginManager = LoginManager()
    public let keychain: Keychain = Keychain()
    
    private init() {}
    
    
}


extension LoginManager {
    
    
    public func isLogin() -> Bool {
        if self.readToken(key: .accessToken).isEmpty {
            return false
        } else {
            return true
        }
    }
    
    public func updateAccessToken(accessToken: String) {
        do {
            try keychain.set(accessToken, key: .accessToken)
        } catch {
            print("😱 HOBBY LOOP ACCESS TOKEN SAVE ERROR \(error.localizedDescription)")
        }
    }
    
    public func updateTokens(accessToken: String, refreshToken: String) {
        do {
            try keychain.set(accessToken, key: .accessToken)
            try keychain.set(refreshToken, key: .refreshToken)
        } catch {
            print("⛔️ HOBBY LOOP TOKEN SAVE ERROR \(error.localizedDescription)")
        }
    }
    
    public func readToken(key: KeychainKeys) -> String {
        do {
            guard let tokenKey = try keychain.get(key.rawValue) else { return "" }
            
            return tokenKey
        } catch {
            print("😵‍💫 HOBBY LOOP TOKEN READ ERROR \(error.localizedDescription)")
            return error.localizedDescription
        }
    }
    
    public func removeToken(key: KeychainKeys) {
        do {
            try keychain.remove(key.rawValue)
        } catch {
            print("📌 HOBBY LOOP TOKEN REMOVE ERROR \(error.localizedDescription)")
        }
    }
    
    public func removeAll() {
        do {
            try keychain.removeAll()
        } catch {
            print("📝 HOBBY LOOP KEYCHAIN REMOVE ALL ERROR \(error.localizedDescription)")
        }
        
    }
}



