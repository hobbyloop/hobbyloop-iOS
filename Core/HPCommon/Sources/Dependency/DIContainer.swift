//
//  DIContainer.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/05/09.
//

import Foundation


public protocol DIContainer {
    associatedtype ViewController
    associatedtype Repository
    associatedtype Reactor
    
    
    func makeViewController() -> ViewController
    func makeRepository() -> Repository
    func makeReactor() -> Reactor
    
    
}
