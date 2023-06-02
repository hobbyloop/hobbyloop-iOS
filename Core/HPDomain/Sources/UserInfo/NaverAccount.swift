//
//  NaverAccount.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/06/02.
//

import Foundation

public struct NaverAccount: Decodable {
    
    /// Naver 응답 상태 Code
    public let resultCode: String
    
    /// Naver 응답 상태 Message
    public let message: String
    
    /// Naver 응답 결과 data
    public let response: NaverResponseInfo
    
    
    
}


public struct NaverResponseInfo: Identifiable ,Decodable {
    
    /// Naver 고유 사용자 ID
    public let id: String
    
    /// Naver 사용자 프로필 이미지
    public let profileImage: URL?
    
    /// Naver 사용자 성별
    public let gender: String
    
    /// Naver 사용자 핸드폰 번호
    public let mobile: String
    
    /// Naver 사용자 지역 포함 번호
    public let regionMobile: String
    
    /// Naver 사용자 이름
    public let name: String
    
    /// Naver 사용자 생일
    public let birthday: String
    
    /// Naver 사용자 생년
    public let birthyear: String
    
    
    enum CodingKeys: CodingKey {
        case id, gender, name
        case mobile, regionMobile
        case birthday, birthyear
        case profileImage
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.profileImage = URL(string: try container.decode(String.self, forKey: .profileImage))
        self.gender = try container.decode(String.self, forKey: .gender)
        self.mobile = try container.decode(String.self, forKey: .mobile)
        self.regionMobile = try container.decode(String.self, forKey: .regionMobile)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.birthyear = try container.decode(String.self, forKey: .birthyear)
    }
}
