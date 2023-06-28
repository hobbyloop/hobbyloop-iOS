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
        var onboardingImage: UIImage
        var onboardingTitle: String
    }
    
    public init(onboardingImage: UIImage, onboardingTitle: String) {
        self.initialState = State(
            onboardingImage: onboardingImage,
            onboardingTitle: onboardingTitle
        )
        print("CellReactor: \(onboardingImage), onboardTtitle: \(onboardingTitle)")
    }
    
    
    
    
}


