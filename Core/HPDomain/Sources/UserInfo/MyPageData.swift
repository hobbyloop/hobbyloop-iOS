//
//  MyPageUserInfo.swift
//  HPDomain
//
//  Created by 김남건 on 6/26/24.
//

import Foundation

/// 마이페이지 화면에서 사용되는 사용자 정보
public struct MyPageData: Decodable {
    public var name: String
    public var nickname: String
    public var phoneNumber: String
    public var profileImageUrl: String?
    public var points: Int
    public var ticketCount: Int
    public var couponCount: Int
    
    public init(name: String, nickname: String, phoneNumber: String, profileImageUrl: String? = nil, points: Int, ticketCount: Int, couponCount: Int) {
        self.name = name
        self.nickname = nickname
        self.phoneNumber = phoneNumber
        self.profileImageUrl = profileImageUrl
        self.points = points
        self.ticketCount = ticketCount
        self.couponCount = couponCount
    }
}

public struct MyPageResponseBody: Decodable {
    public let data: MyPageData
}
