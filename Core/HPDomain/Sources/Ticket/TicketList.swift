//
//  TicketList.swift
//  HPDomain
//
//  Created by 김진우 on 2023/10/12.
//

import Foundation

public struct FacilityInfo: Decodable {
    /// 업체 번호
    public let facilityId: Int
    /// 업체 이름
    public let facilityName: String
    /// 업체 소개 이미지
    public let repImageUrl: String
    /// 업체 주소
    public let address: String
    /// 업체 별점
    public let score: Double
    /// 업체가 제공하는 티켓들
    public let tickets: [Tickets]
    /// 북마크 여부
    public let bookmarked: Bool
    
    #warning("김진우 - TODO: API 연동 이후 삭제할 것")
    public init(facilityId: Int, facilityName: String, repImageUrl: String, address: String, score: Double, tickets: [Tickets], bookmarked: Bool) {
        self.facilityId = facilityId
        self.facilityName = facilityName
        self.repImageUrl = repImageUrl
        self.address = address
        self.score = score
        self.tickets = tickets
        self.bookmarked = bookmarked
    }
}

public struct Tickets: Decodable {
    /// 티켓 아이디
    public let ticketId: Int
    /// 티켓 이미지
    public let ticketImageUrl: String
    /// 티켓 이름
    public let ticketName: String
    ///티켓 가격
    public let price: Int
}
