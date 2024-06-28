//
//  PointHistory.swift
//  HPDomain
//
//  Created by 김남건 on 6/28/24.
//

import Foundation

public struct PointHistory: Decodable {
    public enum PointHistoryType: String, Decodable {
        case earn = "EARN"
        case use = "USE"
    }
    
    public let type: PointHistoryType
    public let amount: Int
    public let balance: Int
    public let description: String
    public let createdAt: Date
    
    enum CodingKeys: CodingKey {
        case type
        case amount
        case balance
        case description
        case createdAt
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(PointHistory.PointHistoryType.self, forKey: .type)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.balance = try container.decode(Int.self, forKey: .balance)
        self.description = try container.decode(String.self, forKey: .description)
        
        let dateString = try container.decode(String.self, forKey: .createdAt)
        let formatter = ISO8601DateFormatter()
        self.createdAt = formatter.date(from: dateString) ?? .now
    }
}

public struct PointHistoryResponseBody: Decodable {
    let data: PointHistoryData
}

public struct PointHistoryData: Decodable {
    let totalPoints: Int
    let pointHistories: [MonthlyPointHistory]
}

public struct MonthlyPointHistory: Decodable {
    let year: String
    let month: String
    let pointHistories: [PointHistory]
    
    enum CodingKeys: CodingKey {
        case yearMonth
        case pointHistories
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let yearMonthArr = try container.decode(String.self, forKey: .yearMonth).components(separatedBy: "/")
        self.year = yearMonthArr[0]
        self.month = yearMonthArr[1]
        self.pointHistories = try container.decode([PointHistory].self, forKey: .pointHistories)
    }
}
