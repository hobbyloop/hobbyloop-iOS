//
//  FacilitySortType.swift
//  HPCommon
//
//  Created by 김진우 on 2023/10/12.
//

import Foundation

public enum FacilitySortType: String, CaseIterable {
    case recently = "최신순"
    case amount = "판매량순"
    case score = "평점순"
    case review = "리뷰순"
    
    public var description: String {
        switch self {
            
        case .recently:
            return "recently"
        case .amount:
            return "amount"
        case .score:
            return "score"
        case .review:
            return "review"
        }
    }
}
