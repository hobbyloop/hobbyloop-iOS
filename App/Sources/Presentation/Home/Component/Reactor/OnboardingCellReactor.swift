//
//  OnboardingCellReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/06/28.
//

import UIKit

import ReactorKit

public final class OnboardingCellReactor: Reactor {
    
    public var initialState: State
    
    public typealias Action = NoAction

    public struct State {
        var onboardingImage: UIImage
    }
    
    public init(onboardingImage: UIImage) {
        self.initialState = State(onboardingImage: onboardingImage)
    }
    
    
    
    
}


