//
//  OnboardingCellReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/06/28.
//

import UIKit

import HPDomain
import ReactorKit

public final class OnboardingCellReactor: Reactor {
    
    public var initialState: State
    
    public typealias Action = NoAction

    public struct State {
        var onboardingImage: String
        var onboardingTitle: String
        @Pulse var onboardingIndex: Int
    }
    
    public init(onboardingImage: String, onboardingTitle: String, onboardingIndex: Int) {
        self.initialState = State(
            onboardingImage: onboardingImage,
            onboardingTitle: onboardingTitle,
            onboardingIndex: onboardingIndex
        )
        print("CellReactor: \(onboardingImage), onboardTtitle: \(onboardingTitle), onboardingIndex: \(onboardingIndex)")
    }
    
    
    
    
}


