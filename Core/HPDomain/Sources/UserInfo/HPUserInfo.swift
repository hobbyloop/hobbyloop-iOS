//
//  UserInfo.swift
//  HPDomain
//
//  Created by 김남건 on 7/6/24.
//

import Foundation

/// 내 정보 수정 화면에서 사용되는 데이터
public struct HPUserInfo: Decodable {
    public var name: String
    public var nickname: String
    public var birthday: String
    public var phoneNumber: String
    public var profileImageUrl: String?
    
    enum CodingKeys: CodingKey {
        case name
        case nickname
        case birthday
        case phoneNumber
        case profileImageUrl
    }
}

public struct UserInfoResponseBody: Decodable {
    public let data: HPUserInfo
}
