//
//  HomeDIContainer.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/03.
//

import Foundation

import HPCommon

final class HomeDIContainer: DIContainer {

    //MARK: Property
    public typealias ViewController = HomeViewController
    public typealias Repository = HomeViewRepo
    public typealias Reactor = HomeViewReactor
    
    func makeViewController() -> HomeViewController {
        return HomeViewController(reactor: makeReactor())
    }
    
    func makeRepository() -> HomeViewRepo {
        return HomeViewRepository()
    }
    
    func makeReactor() -> HomeViewReactor {
        return HomeViewReactor(homeRepository: makeRepository())
    }
    
    
}
