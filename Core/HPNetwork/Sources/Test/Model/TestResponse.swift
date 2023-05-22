//
//  TestResponse.swift
//  HPNetwork
//
//  Created by 김진우 on 2023/04/10.
//

import Foundation

public struct TestResponse: Codable {
    let statusCode: Int?
    let data: [String]?
    
    enum CodingKeys: CodingKey {
        case statusCode, data
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try? values.decode(Int.self, forKey: .statusCode)
        data = try? values.decode([String].self, forKey: .data)
    }
}
