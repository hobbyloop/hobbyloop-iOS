//
//  UserAccount.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/08/21.
//

import Foundation


public struct UserAccount: Decodable {
    public var data: UserAccountData
    
    public struct UserAccountData: Decodable {
        public var accessToken: String
        public var refreshToken: String
    }
}
