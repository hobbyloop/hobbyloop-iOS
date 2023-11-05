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
    
    public init(signUpAccountType: AccountType) {
        self.signUpAccountType = signUpAccountType
    }
    
    
    public func makeViewController() -> SignUpViewController {
        return SignUpViewController(reactor: makeReactor())
    }
    
    public func makeRepository() -> SignUpViewRepo {
        return SignUpViewRepository()
    }
    
    public func makeReactor() -> SignUpViewReactor {
        return SignUpViewReactor(signUpRepository: makeRepository(), accountType: signUpAccountType)
    }
    
}
