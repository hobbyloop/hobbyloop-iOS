//
//  UserAccount.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/08/21.
//

import Foundation


public struct UserInfoParameters: Encodable {
    
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



public struct UserAccount: Codable {
    
    public let status: Int
    
}
