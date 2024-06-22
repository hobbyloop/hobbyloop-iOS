//
//  SignUpDIContainer.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import Foundation

import HPCommon
import HPNetwork


public final class SignUpDIContainer: DIContainer {
    
    
    //MARK: Property
    public typealias ViewController = SignUpViewController
    public typealias Repository = SignUpViewRepo
    public typealias Reactor = SignUpViewReactor
    
    public var signUpAccountType: AccountType
    public var subject: String
    public var oauth2AccessToken: String
    public var email: String
    
    public init(signUpAccountType: AccountType, subject: String, oauth2AccessToken: String, email: String) {
        self.signUpAccountType = signUpAccountType
        self.subject = subject
        self.oauth2AccessToken = oauth2AccessToken
        self.email = email
    }
    
    
    public func makeViewController() -> SignUpViewController {
        return SignUpViewController(reactor: makeReactor())
    }
    
    public func makeRepository() -> SignUpViewRepo {
        return SignUpViewRepository()
    }
    
    public func makeReactor() -> SignUpViewReactor {
        return SignUpViewReactor(signUpRepository: makeRepository(), accountType: signUpAccountType, subject: subject, oauth2AccessToken: oauth2AccessToken, email: email)
    }
    
}
