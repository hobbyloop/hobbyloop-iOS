//
//  Facility.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/09/24.
//

import Foundation



public struct Facility: Decodable {
    
    public let status: Int
    public let facilityInfo: [FacilityInfo]
    
    public enum CodingKeys: String, CodingKey {
        case status
        case facilityInfo = "data"
    }
    
}


public struct FacilityInfo: Decodable {
    public let facilityId: Int
    public let facilityName: String
    public let facilityImageURL: String
    public let facilityAddress: String
    public let facilityScore: Double
    public let facilityLongitude: Int
    public let facilityLatitude: Int
    
    
    public enum CodingKeys: String, CodingKey {
        case facilityId
        case facilityName
        case facilityImageURL = "repImageUrl"
        case facilityAddress = "address"
        case facilityScore = "score"
        case facilityLongitude = "mapx"
        case facilityLatitude = "mapy"
        
        
        
    }
    
}
