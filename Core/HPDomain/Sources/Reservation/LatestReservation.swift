//
//  LatestReservation.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/10/06.
//

import Foundation

public struct LatestReservation: Decodable {
    public let statusCode: String?
    public let data: LatestReservationInfo?
    public let exceptionCode: String?
    public let message: String?
    
    public enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case data
        case exceptionCode
        case message
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusCode = try container.decode(String.self, forKey: .statusCode)
        self.data = try container.decode(LatestReservationInfo.self, forKey: .data)
        self.exceptionCode = try container.decodeIfPresent(String.self, forKey: .exceptionCode) ?? nil
        self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? nil
    }
    
}

public struct LatestReservationInfo: Decodable {
    public let lessonName: String
    public let facilityName: String
    public let instructorName: String
    public let lessonStart: String
    public let lessonEnd: String
}
