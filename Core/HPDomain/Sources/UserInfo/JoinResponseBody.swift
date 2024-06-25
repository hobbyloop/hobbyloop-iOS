//
//  UserAccount.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/08/21.
//

import Foundation


public struct JoinResponseBody: Decodable {
    public var data: JoinTokenData
    
    public struct JoinTokenData: Decodable {
        public var accessToken: String
        public var refreshToken: String
    }
}
