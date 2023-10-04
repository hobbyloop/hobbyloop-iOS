//
//  LoginManager.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/10/04.
//

import Foundation

import HPExtensions
import Alamofire

public protocol Authenticationable {
    func isLogin() -> Bool
    func updateToken(accessToken: String, refreshToken: String)
    func removeToken()
}

public final class LoginManager: Authenticationable {
    static let shaerd: LoginManager = LoginManager()
    
    //MARK: Property
    private(set) var accessToken: String = "" {
        didSet{
            UserDefaults.standard.set(accessToken, forKey: .accessToken)
        }
    }
    
    private(set) var refreshToken: String = "" {
        didSet {
            UserDefaults.standard.set(refreshToken, forKey: .refreshToken)
        }
    }
    

    private init() {}
    
    
}


extension LoginManager {
    
    
    public func isLogin() -> Bool {
        if UserDefaults.standard.string(forKey: .accessToken).isEmpty {
            return false
        } else {
            return true
        }
    }
    
    public func updateToken(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    public func removeToken() {
        self.accessToken = ""
        self.refreshToken = ""
    }
}



