//
//  SignUpDIContainer.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import Foundation


import HPCommon
import HPNetwork


final class SignUpDIContainer: DIContainer {
    
    
    //MARK: Property
    public typealias ViewController = SignUpViewController
    public typealias Repository = SignUpViewRepo
    public typealias Reactor = SignUpViewReactor
    
    public var signUpClient: APIService
    public var signUpAccountType: AccountType
    
    public init(signUpClient: APIService, signUpAccountType: AccountType) {
        self.signUpClient = signUpClient
        self.signUpAccountType = signUpAccountType
    }
    
    
    func makeViewController() -> SignUpViewController {
        return SignUpViewController(reactor: makeReactor())
    }
    
    func makeRepository() -> SignUpViewRepo {
        return SignUpViewRepository(APIService: signUpClient)
    }
    
    func makeReactor() -> SignUpViewReactor {
        return SignUpViewReactor(signUpRepository: makeRepository(), accountType: signUpAccountType)
    }
    
}
