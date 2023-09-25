//
//  NaverAccount.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/06/02.
//

import Foundation

public struct NaverAccount: Decodable {
    
    /// Naver 응답 상태 Code
    public let resultcode: String
    
    /// Naver 응답 상태 Message
    public let message: String
    
    /// Naver 응답 결과 data
    public let response: NaverResponseInfo?
    
    public enum CodingKeys: String, CodingKey {
        case resultcode, message
        case response
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resultcode = try container.decode(String.self, forKey: .resultcode)
        self.message = try container.decode(String.self, forKey: .message)
        self.response = try container.decodeIfPresent(NaverResponseInfo.self, forKey: .response) ?? nil
        
    }
    
    
}


public struct NaverResponseInfo: Identifiable ,Decodable {
    
    /// Naver 고유 사용자 ID
    public let id: String?
    
    /// Naver 사용자 프로필 이미지
    public let profileImage: URL?
    
    /// Naver 사용자 성별
    public let gender: String?
    
    /// Naver 사용자 핸드폰 번호
    public let mobile: String?
    
    /// Naver 사용자 지역 포함 번호
    public let regionMobile: String?
    
    /// Naver 사용자 이름
    public let name: String?
    
    /// Naver 사용자 생일
    public let birthday: String?
    
    /// Naver 사용자 생년
    public let birthyear: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id, gender, name
        case mobile
        case regionMobile = "mobile_e164"
        case birthday, birthyear
        case profileImage = "profile_image"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.profileImage = URL(string: try container.decodeIfPresent(String.self, forKey: .profileImage) ?? "")
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender) ?? ""
        self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile) ?? ""
        self.regionMobile = try container.decodeIfPresent(String.self, forKey: .regionMobile) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.birthday = try container.decodeIfPresent(String.self, forKey: .birthday) ?? ""
        self.birthyear = try container.decodeIfPresent(String.self, forKey: .birthyear) ?? ""
    }
}
