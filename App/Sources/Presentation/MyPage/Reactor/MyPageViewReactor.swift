//
//  MyPageViewReactor.swift
//  Hobbyloop
//
//  Created by 김남건 on 6/26/24.
//

import Foundation
import ReactorKit
import HPDomain
import UIKit

public final class MyPageViewReactor: Reactor {
    public var initialState: State =
    State(data: MyPageData(name: "이름", nickname: "닉네임", phoneNumber: "010-1234-1234", points: 50000, ticketCount: 3, couponCount: 3), isLoading: false)
    private let repository: MyPageViewRepo
    
    public enum Action {
        case viewWillAppear
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setMyPageData(MyPageData)
        case setProfileImage(UIImage?)
    }
    
    public struct State {
        var data: MyPageData
        var isLoading: Bool
        var profileImage: UIImage?
    }
    
    init(repository: MyPageViewRepo) {
        self.repository = repository
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return .concat([
                .just(.setLoading(true)),
                repository.getMyPageData(),
                .just(.setLoading(false))
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .setMyPageData(let myPageData):
            newState.data = myPageData
        case .setProfileImage(let image):
            newState.profileImage = image
        }
        
        return newState
    }
}
