//
//  Token.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/10/27.
//

import Foundation


public struct Token: Decodable {
    
    /// Token Entity의 statusCode 값
    public let statusCode: Int
    
    /// 하비루프 사용자의 토근을 담고 있는 객체
    public let userToken: TokenInfo
    
    public enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case userToken = "data"
    }
}

public struct TokenInfo: Decodable {
    
    /// 하비루프 사용자 accessToken 값
    public let accessToken: String
    
    /// 하비루프 사용자 refreshToken 값
    public let refreshToken: String
    
    public enum CodingKeys: String, CodingKey {
        case accessToken = "authorization"
        case refreshToken = "authorizationRefresh"
    }
    
}
