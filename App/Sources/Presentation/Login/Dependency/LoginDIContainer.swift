//
//  LoginDIContainer.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/09.
//

import Foundation

import HPCommon


public final class LoginDIContainer: DIContainer {

    //MARK: Property
    public typealias ViewController = LoginViewController
    public typealias Repository = LoginViewRepo
    public typealias Reactor = LoginViewReactor
    
    public func makeViewController() -> LoginViewController {
        return LoginViewController(reactor: makeReactor())
    }
    
    public func makeRepository() -> LoginViewRepo {
        return LoginViewRepository()
    }
    
    public func makeReactor() -> LoginViewReactor {
        return LoginViewReactor(loginRepository: makeRepository())
    }
    
    
}
