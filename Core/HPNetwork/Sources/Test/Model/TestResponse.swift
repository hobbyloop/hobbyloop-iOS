//
//  TestResponse.swift
//  HPNetwork
//
//  Created by 김진우 on 2023/04/10.
//

import Foundation

public struct TestResponse: Codable {
    public let userId: Int
    public let id: Int
    public let title: String
    public let completed: Bool
    
    enum CodingKeys: CodingKey {
        case userId, id, title, completed
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.completed = try container.decode(Bool.self, forKey: .completed)
    }
}
