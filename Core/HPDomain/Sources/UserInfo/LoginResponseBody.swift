//
//  Token.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/10/27.
//

import Foundation


public struct LoginResponseBody: Decodable {
    public let data: LoginTokenData
}

public struct LoginTokenData: Decodable {
    /// 하비루프 사용자 accessToken 값
    public let accessToken: String?
    
    /// 하비루프 사용자 refreshToken 값
    public let refreshToken: String?
    public let email: String?
    public let provider: String?
    public let subject: String?
    public let oauth2AccessToken: String?
}
