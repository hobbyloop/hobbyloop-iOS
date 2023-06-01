//
//  BaseEntity.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/06/01.
//

import Foundation

/// 공용 Response Entity
public struct BaseEntity<T>: Decodable where T: Decodable {
    
    /// 응답 상태 Code
    public let status: Int
    
    /// 응답 결과 data
    public let data: T?
    
    
    enum CodingKeys: CodingKey {
        case status
        case data
    }
    
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<BaseEntity<T>.CodingKeys> = try decoder.container(keyedBy: BaseEntity<T>.CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: BaseEntity<T>.CodingKeys.status) ?? 404
        self.data = try container.decodeIfPresent(T.self, forKey: BaseEntity<T>.CodingKeys.data)
    }
    
    
}
