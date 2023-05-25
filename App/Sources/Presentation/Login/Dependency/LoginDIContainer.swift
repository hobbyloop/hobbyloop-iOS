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
    public typealias Repository = LoginViewRepo
    public typealias Reactor = LoginViewReactor
    
    func makeViewController() -> LoginViewController {
        return LoginViewController(reactor: makeReactor())
    }
    
    func makeRepository() -> LoginViewRepo {
        return LoginViewRepository()
    }
    
    func makeReactor() -> LoginViewReactor {
        return LoginViewReactor()
    }
    
    
}
