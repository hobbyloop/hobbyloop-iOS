//
//  UserAccount.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/08/21.
//

import Foundation


public struct UserAccount: Decodable {
    
    /// UserAccount Entity의 StatusCode 값
    public let statusCode: Int
    
    /// 하비루프 사용자 정보를 담고 있는 객체
    public let userInfo: UserAccountInfo
    
    
    public enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case userInfo = "data"
        
    }
}


public struct UserAccountInfo: Decodable {
    
    /// 하비루프 사용자 이름
    public let name: String
    
    /// 하비루프 사용자 닉네임
    public let nickname: String
    
    /// 하비루프 사용자 성별
    public let gender: String
    
    /// 하비루프 사용자 생년월일
    public let birth: String
    
    /// 하비루프 사용자 휴대폰 번호
    public let phoneNum: String
    
    
}
