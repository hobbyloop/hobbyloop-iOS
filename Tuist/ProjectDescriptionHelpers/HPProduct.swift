//
//  HPProduct.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 2023/04/05.
//

import Foundation

public enum HPProductState {
    case `static`, `dynamic`
}

public enum HPProduct: Equatable {
    
    var isLibrary: Bool {
        return (self == .library(.static) || self == .library(.dynamic))
    }
    
    var isFramework: Bool {
        return (self == .framework(.static) || self == .framework(.dynamic)) 
    }
    
    case app
    
    case library(HPProductState)

    case framework(HPProductState)
    
    case tests
    case unitTests
    case uiTests
    
    case bundle
    
}


