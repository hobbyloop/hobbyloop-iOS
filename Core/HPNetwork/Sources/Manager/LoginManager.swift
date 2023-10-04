//
//  LoginManager.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/10/04.
//

import HPExtensions

import Alamofire
import Foundation

public protocol Authenticationable {
    func isLogin() -> Bool
    func updateToken(accessToken: String, refreshToken: String)
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


public extension LoginManager {
    
    func isLogin() -> Bool {
        if UserDefaults.standard.string(forKey: .accessToken).isEmpty {
            return false
        } else {
            return true
        }
    }
    
    
    func updateToken(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}



