//
//  UserInfo.swift
//  HPDomain
//
//  Created by 김남건 on 7/6/24.
//

import Foundation

/// 내 정보 수정 화면에서 사용되는 데이터
public struct HPUserInfo: Decodable {
    var name: String
    var nickname: String
    var birthday: String
    var phoneNumber: String
    var profileImageUrl: URL
}
