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

public protocol Authenticationable {
    func isLogin() -> Bool
    func updateToken(accessToken: String, refreshToken: String)
    func removeToken()
    func updateUserInfo(userInfo: UserAccount)
}

public final class LoginManager: Authenticationable {
    public static let shared: LoginManager = LoginManager()
    
    
    //MARK: Property
    public private(set) var accessToken: String = "" {
        didSet{
            UserDefaults.standard.set(accessToken, forKey: .accessToken)
        }
    }
    
    public private(set) var refreshToken: String = "" {
        didSet {
            UserDefaults.standard.set(refreshToken, forKey: .refreshToken)
        }
    }
    
    
    public private(set) var userInfo: UserAccount? = nil {
        didSet {
            UserDefaults.standard.set(userInfo, forKey: .userInfo)
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
    
    public func updateUserInfo(userInfo: UserAccount) {
        self.userInfo = userInfo
    }
    
    public func removeToken() {
        self.accessToken = ""
        self.refreshToken = ""
    }
}



