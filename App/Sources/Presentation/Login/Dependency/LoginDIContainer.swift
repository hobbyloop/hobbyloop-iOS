//
//  LoginDIContainer.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/09.
//

import Foundation


import HPCommon


final class LoginDIContainer: DIContainer {

    //MARK: Property
    public typealias ViewController = LoginViewController
    public typealias Repository = LoginViewRepository
    public typealias Reactor = LoginViewReactor
    
    func makeViewController() -> LoginViewController {
        return LoginViewController(reactor: makeReactor())
    }
    
    func makeRepository() -> LoginViewRepository {
        return LoginViewRepository()
    }
    
    func makeReactor() -> LoginViewReactor {
        return LoginViewReactor()
    }
    
    
}
