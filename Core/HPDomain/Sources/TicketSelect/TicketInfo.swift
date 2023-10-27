//
//  TicketInfo.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/09/28.
//

import Foundation


public struct TicketInfo: Decodable {
    
    public let status: Int
    public let data: [TicketEntity]
    
}


public struct TicketEntity: Decodable {
    
    public let centerName: String
    public let ticketInfo: [TicketUserEntity]
    public let startDate: String
    public let endDate: String
    
    public enum CodingKeys: String, CodingKey {
        case ticketInfo = "ticketInfos"
        case startDate, endDate
        case centerName
    }
    
    
}


public struct TicketUserEntity: Decodable {
    public let ticketImageURL: String
    public let ticketName: String
    public let ticketCount: Int
    
    
    public enum CodingKeys: String, CodingKey {
        case ticketImageURL = "ticketImageUrl"
        case ticketName
        case ticketCount = "count"
    }
    
    
}
