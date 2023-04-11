//
//  TestModel.swift
//  HPNetwork
//
//  Created by 김진우 on 2023/04/10.
//

import Foundation

struct TestModel: Codable {
    let statusCode: Int?
    let data: [String]?
    
    enum CodingKeys: CodingKey {
        case statusCode, data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = (try? values.decode(Int.self, forKey: .statusCode)) ?? nil
        data = (try? values.decode([String].self, forKey: .data)) ?? nil
    }
}
