//
//  LatestReservation.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/10/06.
//

import Foundation

public struct LatestReservation: Decodable {
    public let statusCode: Int
    public let data: LatestReservationInfo
    
    public enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case data
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode) ?? 500
        self.data = try container.decode(LatestReservationInfo.self, forKey: .data)
    }
    
}

public struct LatestReservationInfo: Decodable {
    public let lessonName: String
    public let facilityName: String
    public let instructorName: String
    public let lessonStart: String
    public let lessonEnd: String
}
