//
//  TicketInstructorProfileCellReactor.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/20.
//

import Foundation

import ReactorKit

public final class TicketInstructorProfileCellReactor: Reactor {
    
    public var initialState: State
    
    public typealias Action = NoAction
    
    public struct State {
        //TODO: Repository 에서 URL로 데이터 변환하도록 코드 추가
        var imageURL: String
        var numberOfPages: Int
        @Pulse var currentPage: Int
    }
    
    public init(imageURL: String, numberOfPages: Int, currentPage: Int) {
        self.initialState = State(
            imageURL: imageURL,
            numberOfPages: numberOfPages,
            currentPage: currentPage
        )
    }
    
    
}
